import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bookshop/appBar.dart';
import 'package:bookshop/controllers/DbController.dart';
import 'package:rxdart/rxdart.dart';

class AccountPage extends StatefulWidget {
  final String userID;

  const AccountPage({Key? key, required this.userID}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  // var usersList = FirebaseFirestore.instance.collection('Users');
  // var usersListSnap = CombineLatestStream.list([FirebaseFirestore.instance.collection('Users').snapshots()]);
  // late var currentUser =  usersList.doc(widget.userID).get();

  getUser(List users) async {
    for (int i = 0; i < users.length; i++) {
      if (users[i]['id'].equals(widget.userID)) {
        return users[i];
      }
    }
    // return await usersList.doc(widget.userID).get();
  }

  getBook(List books, String bookId) async {
    for (int i = 0; i < books.length; i++) {
      if (books[i]['id'].equals(bookId)) {
        return books[i];
      }
    }
  }

  /**
   * Update the user's wish list, remove the current book from the list
   */
  deleteSavedBook(String userId, List usersInfo) async {
    var user = getUser(usersInfo);
    List savedBooks = user['wishlist'];
  }

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
            var usersInfo = [
              ...dbBooks.map((book) => {
                    'id': book.id,
                    'isbn': book['isbn'],
                    'book_name': book['book_name'],
                    'author': book['author'],
                    'country': book['country'],
                    'genres': book['genres'],
                    'description': book['description'],
                    'quantity': book['quantity'],
                    'price': book['price'],
                    'available': book['available'],
                    'type': 'book'
                  }),
            ];
            var booksInfo = [
              ...dbUsers.map((customer) => {
                    'id': customer.id,
                    'first_name': customer['first_name'],
                    'last_name': customer['last_name'],
                    'phone_number': customer['phone_number'],
                    'email': customer['email'],
                    'password_hash': customer['password_hash'],
                    'wishList': customer['wishList'],
                    'cart': customer['cart'],
                    'type': 'user'
                  }),
            ];

            var currentUser = getUser(usersInfo);
            var savedBooks = currentUser['wishlist'];
            return Column(
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Welcome back ${currentUser['first_name']} ')
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      //TODO: image link from db
                      Image(
                        image: AssetImage('assetName'),
                        width: 200,
                      ),
                      Column(
                        children: [
                          Text(
                              '${currentUser['last_name']}, ${currentUser['first_name']}'),
                          Text('${currentUser['email']}'),
                          Text('${currentUser['phone_number']}')
                        ],
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Your WishList!"),
                    Icon(
                      Icons.bookmark,
                      color: Colors.redAccent,
                    )
                  ],
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: savedBooks.length,
                  itemBuilder: (context, i) {
                    final currentBookId = savedBooks[i];
                    final currentBook = getBook(booksInfo, currentBookId);
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 2),
                      child: ListTile(
                        //TODO: put image holder or link to book image
                        leading: Image(image: AssetImage('assetName')),
                        title: Text(
                          currentBook['book_name'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(currentBook['author']),
                        trailing: Wrap(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(currentBook['price']),
                            IconButton(
                              onPressed: () {
                                // TODO: delete the current book from the wish list
                                // deleteTask(currentTask['id']);
                                List<dynamic> cartArray = currentUser['cart'];
                                cartArray.remove(currentBookId); //???????
                              },
                              icon: Icon(
                                Icons.delete_forever,
                                color: Colors.red,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  //TODO: put current book in cart array instead of wishlist array
                                  List<dynamic> cartArray = currentUser['cart'];
                                  cartArray.add(currentBookId);
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
                ))
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
      appBar: buildAppBar(),
      backgroundColor: Colors.orange.shade100,
      body: Center(
        child: buildBodyList()
        ),
      );
  }
}
