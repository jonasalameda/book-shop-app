import 'dart:developer';

import 'package:bookshop/common.dart';
import 'package:bookshop/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bookshop/appBar2.dart';

import 'package:bookshop/controllers/DbController.dart';
import 'package:rxdart/rxdart.dart';

class DescriptionPage extends StatefulWidget {
  final String bookId;

  DescriptionPage({Key? key, required this.bookId}) : super(key: key);

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  buildDescription(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as Map;
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: StreamBuilder<List<QuerySnapshot>>(
            stream: CombineLatestStream.list([
              FirebaseFirestore.instance.collection('Users').snapshots(),
              FirebaseFirestore.instance.collection('Books').snapshots()
            ]),
            builder: (context, snapshot) {
              var dbUsers = snapshot.data![0].docs;
              var dbBooks = snapshot.data![1].docs;

              var usersInfo = [
                ...dbUsers.map((customer) {
                  var data = customer.data() as Map<String, dynamic>?;
                  return {
                    'id': customer.id,
                    'first_name': data?['first_name'] ?? '',
                    'last_name': data?['last_name'] ?? '',
                    'phone_number': data?['phone_number'] ?? '',
                    'email': data?['email'] ?? '',
                    'password_hash': data?['password_hash'] ?? '',
                    'wishlist': data?['wishlist'] ?? [],
                    'cart': data?['cart'] ?? [],
                    'role': data?['role'] ?? '',
                    'type': 'user'
                  };
                }),
              ];
              var booksInfo = [
                ...dbBooks.map((book) {
                  var data = book.data() as Map<String, dynamic>?;
                  return {
                    'id': book.id,
                    'isbn': data?['isbn'] ?? '',
                    'book_name': data?['book_name'] ?? '',
                    'author': data?['author'] ?? '',
                    'country': data?['country'] ?? '',
                    'genres': data?['genres'] ?? [],
                    'description': data?['description'] ?? '',
                    'image': data?['image'] ?? '',
                    'quantity': data?['quantity'] ?? 0,
                    'price': data?['price'] ?? 0.00,
                    'available': data?['available'] ?? false,
                    'type': 'book'
                  };
                }),
              ];

              var currentUser = getUser(usersInfo, currentUserID!);
              var currentBook = getBook(booksInfo, widget.bookId);

              // String? bookId;

              return Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      currentBook['image'].isEmpty
                          ? Image(image: AssetImage('bookPlaceholder.jpg'))
                          : Image(
                              image: NetworkImage(item['image']),
                              width: 300,
                              height: 300,
                            ),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.all(32),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                currentBook['name'],
                                style: TextStyle(
                                    fontSize: 25,
                                    decoration: TextDecoration.underline),
                              ),
                              Text(
                                "\$${currentBook['price']}",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Author: ${currentBook['author']}"),
                              Text("Stock: ${currentBook['quantity']}"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    List<dynamic> cartArray =
                                        currentUser['cart'];
                                    await FirebaseFirestore.instance
                                        .collection('Users')
                                        .doc(currentUserID!)
                                        .update({
                                      'cart':
                                          FieldValue.arrayUnion([currentBook])
                                    });
                                    if(cartArray.contains(currentBook)){
                                      showErrorDialog("Item already in cart", "This item is already in your cart you can checkout any time", context);
                                    }
                                    else{
                                      showSuccess("item added successfully to cart", "Book is now in your cart check out before stock ends :)", context);
                                    }
                                  },
                                  icon: Icon(Icons.favorite)),
                            ],
                          )
                        ],
                      ))
                ],
              );
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final item = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: buildAppBar(context),
      drawer: customerDrawer(context, 0),
      body: Center(child: buildDescription(context)),
    );
  }
}
