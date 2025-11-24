/**
 * Here lies all functionalities/back-end logic of Book class
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../controllers/DbController.dart' show BookDB;

class BookModel {
  int book_id;
  String book_name;
  String author;
  String country;
  List<String> genres;
  String description;
  int quantity;
  double price;
  bool available;

  final CollectionReference books = BookDB().books;

  BookModel(this.book_id, this.book_name, this.author, this.country,
      this.genres, this.description, this.quantity, this.price, this.available);

  /**
   * Create operation on book table will add a book must set the values back to empty after calling it
   */
  Future<void> addBook() async {
    if (book_name.isNotEmpty &&
        author.isNotEmpty &&
        country.isNotEmpty &&
        genres.isNotEmpty &&
        description.isNotEmpty &&
        quantity >= 0 &&
        price > 0.0) {
      await books.add({
        'book_name': book_name,
        'author': author,
        'country': country,
        'genres': genres,
        'description': description,
        'quantity': quantity,
        'price': price,
        'available': available
      });
    }
  }

  /**
   * Update details of existing book such as change in title
   * or author change name, as well as listing
   * the book for new prices or getting new stock for said book
   */
  Future<void> updateBook(String bookID, String bookName, String newDescription,
      String authorName, double newPrice, int newQuantity) async {
    if (bookName.isNotEmpty) {
      await books.doc(bookID).update({'book_name': bookName});
    }
    if (newDescription.isNotEmpty) {
      await books.doc(bookID).update({'description': newDescription});
    }
    if (authorName.isNotEmpty) {
      await books.doc(bookID).update({'author': authorName});
    }
    await books
        .doc(bookID)
        .update({'price': newPrice, 'quantity': newQuantity});
  }

  /**
   * Delete a book from the database through its id
   */
  Future<void> deleteBook(String bookID) async {
    await books.doc(bookID).delete();
  }

  /// Maps without the ID

  Map<String, Object?> toMap() {
    return {
      'book_name': book_name,
      'author': author,
      'country': country,
      'genres': genres,
      'description': description,
      'quantity': quantity,
      'price': price,
      'available': available,
    };
  }
}
