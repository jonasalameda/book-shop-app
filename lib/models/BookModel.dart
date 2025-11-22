import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bookshop/views/loginpage.dart';

/**
 * Here lies all functionalities/back-end logic of Book class
 */
class BookModel {
  String book_id;
  String book_name;
  String author;
  String country;
  List<String> genres;
  String description;
  int quantity;
  double price;
  bool available;

  final CollectionReference books = FirebaseFirestore.instance.collection(
    'Books',
  );

  BookModel(
    this.book_id,
    this.book_name,
    this.author,
    this.country,
    this.genres,
    this.description,
    this.quantity,
    this.price,
    this.available,
  );

  Future<void> addBook() async {
    await books.add({
      'name': book_name,
      'author': author,
      'country': country,
      'genres': genres,
      'description': description,
      'quantity': quantity,
      'price': price,
      'available': available,
    });
  }

  Future<void> deleteBook(String id) async {
    await books.doc(id).delete();
  }

  Future<void> updateBook(id) async {
    await books.doc(id).update({
      'name': book_name,
      'author': author,
      'country': country,
      'genres': genres,
      'description': description,
      'quantity': quantity,
      'price': price,
      'available': available,
    });
  }
}
