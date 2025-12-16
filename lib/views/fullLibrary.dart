import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bookshop/appBar2.dart';
import 'package:bookshop/controllers/DbController.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bookshop/common.dart';
import 'package:bookshop/main.dart';
import '../l10n/app_localizations.dart';

//User: bookstore@admin.com, psw: 123123123
enum MenuItem { view, cart, wishlist}

class fullLibrary extends StatefulWidget {

  const fullLibrary({Key? key}) : super(key: key);

  @override
  State<fullLibrary> createState() => _fullLibraryState();
}

class _fullLibraryState extends State<fullLibrary> {
  final _selectedIndex = 0;
  String _searchText = '';
  final _searchController = TextEditingController();
  MenuItem? selectedItem;
  Timer? _searchTimer;


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
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data == null || snapshot.data!.length < 2) {
              return const Center(child: CircularProgressIndicator());
            }

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
                  'image': data?['image'] ?? 'assets/bookPlaceholder.jpg',
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

            final filteredBooks = _searchText.isEmpty
                ? booksInfo
                : booksInfo.where((book) {
              final title =
              (book['book_name'] ?? '').toString().toLowerCase();
              final author =
              (book['author'] ?? '').toString().toLowerCase();
              // final genres = (book['genres'] ?? []);
              final List genres = book['genres'] is List ? book['genres'] : [];

              final bool genreMatches = genres.any((genre) =>
                  genre.toString().toLowerCase().contains(_searchText));

              return title.contains(_searchText) ||
                  author.contains(_searchText) ||
                  genreMatches;
            }).toList();

            return Column(
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                //     SizedBox(height: 10),
                //     Text(
                //       AppLocalizations.of(context)?.accountGreeting(currentUser['first_name']) ?? '',
                //       // .accountGreeting(currentUser['first_name']),
                //       style: TextStyle(
                //         fontSize: 20,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     )
                //   ],
                // ),
                // Row(
                //   children: [
                //     //TODO: image link from db if it has
                //     Image(
                //       image: AssetImage('assets/profilePlaceHolder.jpg'),
                //       width: 200,
                //     ),
                //     Column(
                //       children: [
                //         Text(
                //             '${currentUser['last_name']}, ${currentUser['first_name']}',
                //             style: TextStyle(fontSize: 20)),
                //         Text('${currentUser['email']}'),
                //         Text('${currentUser['phone_number']}')
                //       ],
                //     )
                  ],
                ),
                SizedBox(height: 25),
                Row(
                  children: [
                    Text(
                      "Library Books:",
                      style:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    //cancel if there was a timer to reset
                    _searchTimer?.cancel();
                    //wait to seconds before updating the search
                    _searchTimer = Timer(Duration(seconds: 2), () {
                      setState(() {
                        _searchText = value.toLowerCase();
                      });
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search book...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredBooks.length,
                    itemBuilder: (context, i) {
                      final book = filteredBooks[i];

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          leading: Image.network(
                            book['image'],
                            width: 60,
                            errorBuilder: (context, error, stackTrace) {
                              return const Image(
                                image:
                                AssetImage('assets/bookPlaceholder.jpg'),
                                width: 60,
                              );
                            },
                          ),
                          title: Text(
                            book['book_name'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(book['author']),
                              Text('Price: \$${book['price']}'),
                              Text('Qty: ${book['quantity']}'),
                              Text('Genres: ${(book['genres'] as List).join(', ')}'),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            // important, otherwise Row tries to expand
                            children: [
                              Icon(
                                book['available']
                                    ? Icons.check_circle
                                    : Icons.cancel,
                                color: book['available']
                                    ? Colors.green
                                    : Colors.red,
                              ),
                              SizedBox(width: 8), // small spacing
                              getMenu(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            onPressed: () {
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
                                  AppLocalizations.of(context)?.accountLogOut ?? '',
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

  Widget getMenu() {
    return PopupMenuButton<MenuItem>(
      initialValue: selectedItem,
      onSelected: (MenuItem item) {
        setState(() {
          selectedItem = item;
        });
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuItem>>[
        PopupMenuItem<MenuItem>(
          value: MenuItem.view,
          child: Text("View Description"),
          onTap: () {
            Navigator.pushNamed(context, '/description');
          },
        ),
        PopupMenuItem<MenuItem>(
          value: MenuItem.cart,
          child: Text("Add to cart"),
        ),
        PopupMenuItem<MenuItem>(
          value: MenuItem.wishlist,
          child: Text("Add to wishlist"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      drawer: customerDrawer(context, _selectedIndex),
      backgroundColor: Colors.orange.shade100,
      body: Column(
        children: [
          buildBodyList()
        ],
      ),
    );
  }
}
