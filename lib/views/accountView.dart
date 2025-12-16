import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bookshop/appBar2.dart';
import 'package:bookshop/controllers/DbController.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bookshop/common.dart';

import '../l10n/app_localizations.dart';

class AccountPage extends StatefulWidget {
  final String userID = currentUserID;

  AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _selectedIndex = 2;

  /**
   * Update the user's wish list, remove the current book from the list
   */
  deleteSavedBook(String userId, List usersInfo, var bookReferenceID) async {
    var user = getUser(usersInfo, widget.userID);
    // print(user.toString());
    // List savedBooks = user['wishlist'];
    // print(savedBooks);
    await FirebaseFirestore.instance.collection('Users').doc(userId).update({
      'wishlist': FieldValue.arrayRemove([bookReferenceID])
    });
  }
  // addToCart(String userId, List usersInfo, var bookReferenceID) async {
  //   // var user = getUser(usersInfo, widget.userID);
  //   // print(user.toString());
  //   // // List savedBooks = user['wishlist'];
  //   // // print(savedBooks);
  //   // CollectionReference users = FirebaseFirestore.instance.collection('Users');
  //   // var currentCart = [];
  //   // var referencesList = users.doc(userId).get();
  //   // print(referencesList.toString());
  //   await FirebaseFirestore.instance.collection('Users').doc(userId).update({
  //     'cart': FieldValue.arrayUnion([bookReferenceID])
  //   });
  // }

  buildBodyList() {
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
                  'image': data?['image'] ?? 'assets/bookPlacehoolder.jpg',
                  'quantity': data?['quantity'] ?? 0,
                  'price': data?['price'] ?? 0.00,
                  'available': data?['available'] ?? false,
                  'type': 'book'
                };
              }),
            ];
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
            // loadCurrentUser();
            var currentUser = getUser(usersInfo, widget.userID);
            var savedBooks = currentUser['wishlist'];

            return Column(
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      AppLocalizations.of(context)!
                          .accountGreeting(currentUser['first_name']),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    //TODO: image link from db if it has
                    Image(
                      image: AssetImage('assets/profilePlaceHolder.jpg'),
                      width: 200,
                    ),
                    Column(
                      children: [
                        Text(
                            '${currentUser['last_name']}, ${currentUser['first_name']}',
                            style: TextStyle(fontSize: 20)),
                        Text('${currentUser['email']}'),
                        Text('${currentUser['phone_number']}')
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 15),
                        Text(
                          AppLocalizations.of(context)!.accountWishList,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown.shade900),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.bookmark,
                          color: Colors.redAccent,
                          size: 30,
                        ),
                        SizedBox(width: 15)
                      ],
                    )
                  ],
                ),
                SizedBox(height: 15),
                Expanded(
                    child: savedBooks.length == 0
                        ? Center(
                            child:
                                Column(children: [CircularProgressIndicator()]))
                        : ListView.builder(
                            itemCount: savedBooks.length,
                            itemBuilder: (context, i) {
                              final currentBookReference = savedBooks[i];
                              // final String currentBookIdDouble = (currentBookReference.id.toString()) as String;
                              final String currentBookId =
                                  currentBookReference.id.toString();
                              final currentBook =
                                  getBook(booksInfo, currentBookId);
                              if (currentBook == null) {
                                return Center(
                                    child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Column(children: [
                                          // Text(currentBookId.value.runtimeType()),
                                          Text(
                                              '${currentBookId.runtimeType}'), // prints a string so id is String but error is double
                                          Text(
                                              '${currentBookId}'), //prints book id so that means the book list is not being fetched right
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Text(savedBooks[i]
                                              .toString()), //WishList List is also being fetched so not an issue
                                          Text(currentBook.toString()),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Text(booksInfo[i]
                                              .toString()), //Book List is also being fetched so not an issue
                                          Text(
                                              '${booksInfo[i]['id'].runtimeType}'), //Book List is also being fetched so not an issue
                                          Text(
                                              "${booksInfo[i]['id'] == currentBookId}"), // returns false :/
                                          // returns trueeeeeeeeee!!!
                                          CircularProgressIndicator()
                                        ])));
                              }
                              //currentBook  is not null and exists
                              return Card(
                                margin: EdgeInsets.symmetric(vertical: 2),
                                child: ListTile(
                                  //TODO: put image holder or link to book image
                                  leading: Image.network(currentBook['image'],
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                    return Image(
                                        image: AssetImage(
                                            'assets/images/placeholder.png'));
                                  }),
                                  title: Text(
                                    currentBook['book_name'],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(currentBook['author']),
                                  trailing: Wrap(
                                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(currentBook['price'].toString()),
                                      IconButton(
                                        onPressed: () {
                                          // TODO: delete the current book from the wish list
                                          deleteSavedBook(widget.userID,
                                              usersInfo, currentBookReference);
                                        },
                                        icon: Icon(
                                          Icons.delete_forever,
                                          color: Colors.red,
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () async {
                                            //TODO: put current book in cart array instead of wishlist array
                                            List<dynamic> cartArray =
                                                currentUser['cart'];
                                            // cartArray.add(currentBookId);
                                            // addToCart(widget.userID, usersInfo, currentBookReference);
                                            await FirebaseFirestore.instance
                                                .collection('Users')
                                                .doc(widget.userID)
                                                .update({
                                              'cart': FieldValue.arrayUnion(
                                                  [currentBookReference])
                                            });
                                            if (cartArray.contains(
                                                currentBookReference)) {
                                              showErrorDialog(
                                                  'Item already in cart',
                                                  'It seems like you have already added this item to your cart',
                                                  context,
                                                  'Okay');
                                            } else {
                                              showSuccess(
                                                  'Item added Successfully',
                                                  'Item is now in your cart you can checkout',
                                                  context);
                                            }
                                          },
                                          icon: Icon(
                                            Icons.add_shopping_cart,
                                            color: Colors.brown,
                                          ))
                                    ],
                                  ),
                                ),
                              );
                            },
                          )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              unloadCurrentUser();
                              Navigator.pop(context);
                              // Navigator.pushNamed(context, '/login');
                              Navigator.popAndPushNamed(context, '/');
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.brown.shade500)),
                            child: Row(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.accountLogOut,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                )
                              ],
                            )),
                      ],
                    ),
                  ],
                )
              ],
            );
          },
        ),
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
          child: Column(
        children: [buildBodyList()],
      )),
    );
  }
}
