import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bookshop/appBar2.dart';
import 'package:bookshop/models/BookModel.dart';
import 'package:bookshop/models/UserModel.dart';
import 'package:bookshop/controllers/DbController.dart';
import 'package:rxdart/rxdart.dart';

class CartPage extends StatefulWidget {
  final String userID;

  const CartPage({Key? key, required this.userID}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CollectionReference allBooks =  FirebaseFirestore.instance.collection('Books');
  final _selectedIndex = 1;
  late var booksInCart;
  double cartSubtotal = 0;
  double federalTax = 5 / 100;
  double provincialTax = 9.975 / 100;
  late double totalCart = cartSubtotal * (federalTax + provincialTax);

  /**
   * Update the user's wish list, remove the current book from the list
   */
  Future<void>deleteBookFromCart(String userId, List usersInfo, var bookReferenceID) async {
    var user = getUser(usersInfo, widget.userID);
    // List booksInCart = user['cart'];
      try {
      await FirebaseFirestore.instance.collection('Users').doc(userId).update({
        'cart': FieldValue.arrayRemove([bookReferenceID])
      });
    }
      catch(e){
        log(e.toString());
      }
  }

  Future<void> decreaseBookQuantity( int currentQuantity,
       String currentBookID) async {
    int newBookQuantity = currentQuantity - 1;
    await updateElement(allBooks, currentBookID, 'quantity', newBookQuantity);
    // return newBookQuantity;
  }
  loadBooks() {
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
                    'quantity': data?['quantity'] ?? 0,
                    'price': data?['price'] ?? 0.00,
                    'available': data?['available'] ?? false,
                    'type': 'book'
                  };
                }),
              ];

              var currentUser = getUser(usersInfo, widget.userID);
              var userCart = currentUser['cart'];
              // String? bookId;

              for(var bookRef in userCart){
                var bookId = bookRef.id;
                var book = getBook(booksInfo, bookId!);
                if(book != null){
                  cartSubtotal += (book['price'] as num).toDouble();
                }
              }
              return Column(
                children: [
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //TODO either fetch image file from user or put a aplace holder
                      Image(image: AssetImage('assets/profilePlaceHolder.jpg'), width: 200,),
                      Column(
                        children: [
                          Text(
                            '${currentUser['last_name']}, ${currentUser['first_name']}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(currentUser['phone_number'], style: TextStyle(fontSize: 15),),
                          Text(currentUser['email'], style: TextStyle(fontSize: 15),),
                          Text('Montreal, QC', style: TextStyle(fontSize: 15),),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Text(userCart.toString()),
                  // Text(currentUser.toString()),
                  // is workin now
                  // Text(bookId.toString()),
                  // Text(cartSubtotal.toStringAsFixed(2)), !!!can access the price
                  Column(
                    children: [
                      Expanded(
                          child: userCart.length == 0 ? Center(child: Text('Your cart is currently empty')) : ListView.builder(
                              itemCount: userCart.length,
                              itemBuilder: (context, i) {
                                final currentBookReference = userCart[i];
                                final String currentBookId = currentBookReference.id;
                                final currentBookInfo = getBook(booksInfo, currentBookId);
                                final bookQuantity = currentBookInfo['quantity'];
                                final bookPrice = currentBookInfo['price'];
                                final bookImage = AssetImage( 'assets/bookPlacehoolder.jpg');

                                return Card(
                                  child: ListTile(
                                    leading: Image(image: bookImage, width: 100,),
                                    title: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(currentBookInfo['book_name'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                        Text(currentBookInfo['author'], style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                    subtitle: Column(
                                      children: [
                                        Text(currentBookInfo['isbn'],style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400)),
                                        IconButton(
                                          onPressed: ()=>deleteBookFromCart(widget.userID, usersInfo, currentBookReference),
                                          icon: Icon(
                                            Icons.delete_forever_outlined,
                                            color: Colors.red,
                                          ),
                                          tooltip: 'Remove from cart',)
                                      ],
                                    ),
                                    trailing: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.brown.shade300,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          // ! it is referencing the amount of books in stock
                                          child: Text('Currently in Stock: $bookQuantity'),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          bookPrice,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              })
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Subtotal: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                          Text('\$${cartSubtotal.toStringAsFixed(2)}: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Federal Tax (5%): ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                          Text('\$${federalTax.toStringAsFixed(2)}: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Provincial Tax (9.975%): ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                          Text('\$${provincialTax.toStringAsFixed(2)}: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total (5%): ', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                          Text('\$${totalCart.toStringAsFixed(2)}: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        ],
                      ),
                      SizedBox(height: 5),
                      Flexible(
                        fit: FlexFit.tight,
                          child: ElevatedButton(
                          onPressed: (){
                            for(var bookRef in userCart){
                              var bookId = bookRef.id;
                              var book = getBook(booksInfo, bookId);
                              if(book != null){
                                decreaseBookQuantity(book['quantity'], bookId);
                              }
                            }
                            // decreaseBookQuantity(books, booksInfo['quantit'], currentBookID)
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown.shade700
                          ),
                          child: Text('CheckOut', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              ))
                    ],
                  )
                ],
              );
            }),
      ),
    );
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      drawer: customerDrawer(context, _selectedIndex),
      backgroundColor: Colors.orange.shade100,
      body: Center(
        child: Column(children: [loadBooks()]),
      ),
    );
  }
}