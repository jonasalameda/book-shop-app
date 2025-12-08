import '../models/BookModel.dart';
import 'package:bookshop/controllers/DbController.dart';

//TODO: link controller to model and view --> Better to just use the controller functions in the view no?
/// BookController communicates with the view to render logic on the code
class BookController {
  // List books =;
  //
  // Future<void> addBook(name, author, country, List<String> genres, description, qtt, price, available) async {
  //   try{
  //     _BookModel _newBook = new _BookModel(name, author, country, genres, description, qtt, price, available);
  //   } catch(Exception) {
  //     print('invalid Fields');
  //     return;
  //   }
  //     await books.add({'name': name, ...});
  // }
  Future<List<BookModel>> getAllBooks() async {
    final List books = await getTableList("Books");

    return books.map((map) => BookModel.fromMap(map)).toList()
        // .cast<BookModel>()
    ;
  }

}

/*
class _BookModel {
  int book_id;
  String book_name;
  String author;
  String country;
  List<String> genres;
  String description;
  int quantity;
  double price;
  bool available;
 */
