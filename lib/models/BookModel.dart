/**
 * Here lies all functionalities/back-end logic of Book class
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class BookModel {
  int isbn;
  String book_name;
  String author;
  String country;
  List<String> genres;
  String description;
  int quantity;
  double price;
  bool available;

  BookModel(this.isbn, this.book_name, this.author, this.country,
      this.genres, this.description, this.quantity, this.price, this.available);

  /// Maps without the ID
  Map<String, Object?> toMap() {
    return {
      'isbn': isbn,
      'book_name':book_name,
      'author':author,
      'country':country,
      'genres':genres,
      'description' : description,
      'quantity' : quantity,
      'price' : price,
      'available' : available,
    };
  }
}
