import 'package:bookshop/models/BookModel.dart';
import 'package:flutter/material.dart';
import 'package:bookshop/appBar2.dart';
import 'package:bookshop/main.dart';
import 'package:bookshop/controllers/BookController.dart';

final adminUser = currentUser;

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _selectedIndex = 0;
  BookController bookController = BookController();
  // late List<BookModel> allBooks = bookController.getAllBooks() as List<BookModel>;
  List<BookModel> allBooks = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadBooks();
  }

  Future<void> _loadBooks() async
  {
    List<BookModel> books = await bookController.getAllBooks();
    setState(() {
      allBooks = books;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFAE9674),
      appBar: buildAppBar(context),
      drawer: adminDrawer(context, _selectedIndex),
      body:
      Column(
        children: [
          if (allBooks.isNotEmpty)
            Text(allBooks[0].book_name)
          else
            const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
