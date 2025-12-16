 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bookshop/appBar2.dart';
import 'package:bookshop/controllers/DbController.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bookshop/common.dart';
import 'package:bookshop/main.dart';
import '../l10n/app_localizations.dart';

//User: bookstore@admin.com, psw: 123123123
enum MenuItem { update, delete, add }

class AdminPage extends StatefulWidget {
  final String userID;

  const AdminPage({Key? key, required this.userID}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _selectedIndex = 1;
  String _searchText = '';
  final  _searchController = TextEditingController();
  MenuItem? selectedItem;

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
            if (currentUser == null) {
              return const Center(child: CircularProgressIndicator());
            }
            final filteredBooks = _searchText.isEmpty ? booksInfo : booksInfo.where((book) {
              final title = (book['book_name'] ?? '').toString().toLowerCase();
              final author = (book['author'] ?? '').toString().toLowerCase();
              final genres = (book['genres'] ?? []);

              final bool genreMatches = genres.any((genre) => genre.toString().toLowerCase().contains(_searchText));

              return title.contains(_searchText) || author.contains(_searchText) || genreMatches;
            }).toList();

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
                SizedBox(height: 15),
                Row(
                  children: [
                    Text("Library Books:", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),),
                  ],
                ),
                TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchText = value.toLowerCase();
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
                                AssetImage('assets/bookPlacehoolder.jpg'),
                                width: 60,
                              );
                            },
                          ),
                          title: Text(
                            book['book_name'],
                            style:
                            const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(book['author']),
                              Text('Price: \$${book['price']}'),
                              Text('Qty: ${book['quantity']}'),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min, // important, otherwise Row tries to expand
                            children: [
                              Icon(
                                book['available'] ? Icons.check_circle : Icons.cancel,
                                color: book['available'] ? Colors.green : Colors.red,
                              ),
                              SizedBox(width: 8), // small spacing
                              getMenu(book['id']),
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

  Widget getMenu(bookId) {
    return PopupMenuButton<MenuItem>(
      initialValue: selectedItem,
      onSelected: (MenuItem item) {
        setState(() {
          selectedItem = item;
        });
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuItem>>[
        PopupMenuItem<MenuItem>(
          value: MenuItem.update,
          child: TextButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    Map<String, dynamic> newBookData = {};
                    String newName = '';
                    String newAuthor = '';
                    String newCountry = '';
                    String newDescription = '';
                    int? newStock;
                    double? newPrice;
                    bool? newAvailability;
                    final List<bool> availabilityOptions = [true, false];
                    String genreInputs = ''; //comma separated input
                    // 'book_name': book_name,
                    // 'author': author,
                    // 'country': country,
                    // 'genres': genres,
                    // 'description': description,
                    // 'quantity': quantity,
                    // 'price': price,
                    // 'available': available,

                    return AlertDialog(
                      title: Text("Update only new fields"),
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextField(
                              onChanged: (value) => newName = value,
                              decoration:
                              InputDecoration(hintText: 'Enter new title'),
                            ),
                            TextField(
                              onChanged: (value) => newAuthor = value,
                              decoration: InputDecoration(hintText: 'Author'),
                            ),
                            TextField(
                              onChanged: (value) => newCountry = value,
                              decoration: InputDecoration(hintText: 'Country'),
                            ),
                            TextField(
                              onChanged: (value) => newDescription = value,
                              decoration:
                              InputDecoration(hintText: 'Description'),
                            ),
                            TextField(
                              onChanged: (value) =>
                              newPrice = double.tryParse(value.trim()),
                              decoration: InputDecoration(hintText: 'Price'),
                            ),
                            TextField(
                              onChanged: (value) =>
                              newStock = int.tryParse(value.trim()),
                              decoration: InputDecoration(hintText: 'Stock'),
                            ),
                            DropdownButtonFormField(
                              decoration: InputDecoration(labelText: 'Availability'),
                              value: newAvailability,
                              items: [
                                DropdownMenuItem(value: true, child: Text('Available')),
                                DropdownMenuItem(value: false, child: Text('Unavailable')),
                              ],
                              onChanged: (value) => newAvailability = value,
                            ),
                            TextField(
                              decoration: const InputDecoration(
                                labelText: 'Genres (comma separated)',
                                hintText: 'Fantasy, Mystery, Sci-Fi',
                              ),
                              onChanged: (value) => genreInputs = value,
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                            onPressed: () async {
                              if (newName.trim().isNotEmpty) {
                                newBookData['book_name'] = newName.trim();
                              }
                              if (newAuthor.trim().isNotEmpty) {
                                newBookData['author'] = newAuthor.trim();
                              }
                              if (newCountry.trim().isNotEmpty) {
                                newBookData['country'] = newCountry.trim();
                              }
                              if (newDescription.trim().isNotEmpty) {
                                newBookData['description'] = newDescription.trim();
                              }
                              if (newPrice != null) {
                                newBookData['price'] = newPrice;
                              }
                              if (newStock != null) {
                                newBookData['quantity'] = newStock;
                              }
                              if (newAvailability != null) {
                                newBookData.addAll({'available': newAvailability});
                              }
                              if (genreInputs.trim().isNotEmpty) {
                                newBookData['genres'] = genreInputs
                                    .split(',').map((g) => g.trim())
                                    .where((g) => g.isNotEmpty).toList();
                              }

                              if (newBookData.isNotEmpty) {
                                await updateBook(bookId, newBookData);
                              } else {
                                showAlert(context,
                                    "Nothing to update."); //general function from main
                              }
                              Navigator.pop(context);
                            },
                            child: Text('Update')),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel'))
                      ],
                    );
                  },
                );
              },
              child: Text("Update Book")),
        ),
        PopupMenuItem<MenuItem>(
          value: MenuItem.delete,
          child: TextButton(
              onPressed: () async {
                await deleteBook(bookId);
              },
              child: Text("Delete Book")),
        ),
        // PopupMenuItem<MenuItem>(value: MenuItem.add, child: Text('Item 3')),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      drawer: adminDrawer(context, _selectedIndex),
      backgroundColor: Colors.orange.shade100,
      body: Center(
          child: Column(
            children: [
              buildBodyList()
            ],
          )),
    );
  }
}
