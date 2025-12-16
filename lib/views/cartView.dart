import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bookshop/appBar2.dart';
import 'package:bookshop/models/BookModel.dart';
import 'package:bookshop/models/UserModel.dart';
import 'package:bookshop/controllers/DbController.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bookshop/common.dart';
import 'paymentPage.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CollectionReference allBooks = FirebaseFirestore.instance.collection('Books');
  final _selectedIndex = 1;
  late var booksInCart;
  late double cartSubtotal = 0;
  late double federalTax = 0;
  late double provincialTax = 0;
  late double totalCart = 0;

  /**
   * Update the user's wish list, remove the current book from the list
   */
  Future<void> deleteBookFromCart(
      String userId, List usersInfo, var bookReferenceID) async {
    var user = getUser(usersInfo, widget.userID);
    // List booksInCart = user['cart'];
    try {
      await FirebaseFirestore.instance.collection('Users').doc(userId).update({
        'cart': FieldValue.arrayRemove([bookReferenceID])
      });
    } catch (e) {
      log(e.toString());
    }
  }

  emptyCart(List userCart, List booksInfo, List usersInfo) async {
    for (var bookRef in userCart) {
      var bookId = bookRef.id;
      var book = getBook(booksInfo, bookId);
      await deleteBookFromCart(widget.userID, usersInfo, bookId);
    }
  }

  Future<bool> decreaseBookQuantity(
      int currentQuantity, String currentBookID) async {
    if (currentQuantity <= 0) {
      // showErrorDialog("Sorry can't checkout", "We are currently out of stock for this item please come back another time", context);
      return false;
    }
    int newBookQuantity = currentQuantity - 1;
    await updateElement(allBooks, currentBookID, 'quantity', newBookQuantity);
    return true;
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
                    'image': data?['image'] ?? '',
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

              double setcartSubtotal() {
                double subtotal = 0;
                for (var bookRef in userCart) {
                  var bookId = bookRef.id;
                  var book = getBook(booksInfo, bookId!);
                  if (book != null) {
                    subtotal += (book['price'] as num).toDouble();
                  }
                }
                return subtotal;
              }

              return Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //TODO either fetch image file from user or put a aplace holder
                      Image(
                        image: AssetImage('assets/profilePlaceHolder.jpg'),
                        width: 200,
                      ),
                      Column(
                        children: [
                          Text(
                            '${currentUser['last_name']}, ${currentUser['first_name']}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                            currentUser['phone_number'],
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            currentUser['email'],
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            'Montreal, QC',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  // Text(userCart.toString()),
                  // Text(currentUser.toString()),
                  // is workin now
                  // Text(bookId.toString()),
                  // Text(cartSubtotal.toStringAsFixed(2)), //!!!can access the price
                  Row(
                    children: [Text("Your Cart:")],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Column(children: [
                  Expanded(
                      child: userCart.length == 0
                          ? Center(child: Text('Your cart is currently empty'))
                          : ListView.builder(
                              itemCount: userCart.length,
                              itemBuilder: (context, i) {
                                final currentBookReference = userCart[i];
                                final String currentBookId =
                                    currentBookReference.id;
                                final currentBookInfo =
                                    getBook(booksInfo, currentBookId);
                                final bookQuantity =
                                    currentBookInfo['quantity'];
                                final bookPrice = currentBookInfo['price'];
                                // final bookImage = currentBookInfo['image']?? 'assets/bookPlacehoolder.jpg';
                                cartSubtotal = setcartSubtotal();
                                federalTax = 5 / 100 * cartSubtotal;
                                provincialTax = 9.975 / 100 * cartSubtotal;
                                totalCart =
                                    cartSubtotal + federalTax + provincialTax;

                                return Card(
                                  margin: EdgeInsets.symmetric(vertical: 2),
                                  child: ListTile(
                                    //TODO: put image holder or link to book image
                                    leading: Image.network(
                                        currentBookInfo['image'], errorBuilder:
                                            (context, error, stackTrace) {
                                      return Image(
                                          image: AssetImage(
                                              'assets/images/placeholder.png'));
                                    }),
                                    title: Text(
                                      currentBookInfo['book_name'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(currentBookInfo['author']),
                                    trailing: Wrap(
                                      direction: Axis.vertical,
                                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            // TODO: delete the current book from the wish list
                                            deleteBookFromCart(
                                                widget.userID,
                                                usersInfo,
                                                currentBookReference);
                                            setcartSubtotal();
                                          },
                                          icon: Icon(
                                            Icons.delete_forever,
                                            color: Colors.red,
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.brown.shade300,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          // ! it is referencing the amount of books in stock
                                          child: Text(
                                            'Currently in Stock: $bookQuantity',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          bookPrice.toString(),
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subtotal: ',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '\$${cartSubtotal.toStringAsFixed(2)}: ',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Federal Tax (5%): ',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '\$${(cartSubtotal * (5 / 100)).toStringAsFixed(2)}: ',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Provincial Tax (9.975%): ',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '\$${provincialTax.toStringAsFixed(2)}: ',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total: ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$${totalCart.toStringAsFixed(2)}: ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Flexible(
                      fit: FlexFit.tight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              var itemsInStock;
                              for (var bookRef in userCart) {
                                var bookId = bookRef.id;
                                var book = getBook(booksInfo, bookId);
                                if (book != null) {
                                  itemsInStock = await decreaseBookQuantity(
                                      book['quantity'], bookId);
                                }
                              }
                              if (itemsInStock) {
                                showSuccessPayment(
                                    'Order Received',
                                    'Thank you for choosing the library of Ruina \n Your total is ${totalCart.toStringAsFixed(2)}',
                                    context,
                                    totalCart);
                                cartSubtotal = 0;

                                emptyCart(userCart, booksInfo, usersInfo);
                              } else {
                                showErrorDialog(
                                    "Error",
                                    "Some of the items in your cart are currently out of stock please try again later",
                                    context);
                              }

                              // decreaseBookQuantity(books, booksInfo['quantit'], currentBookID)
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.brown.shade700,
                                minimumSize: Size(300, 100)),
                            child: Text(
                              'CheckOut',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ))
                  // ],)
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
