/**
 * Here lies all functionalities/back-end logic of Book class
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class BookModel {
  String id;
  int isbn;
  String book_name;
  String author;
  String country;
  List<String> genres;
  String description;
  int quantity;
  double price;
  bool available;

  BookModel(this.id, this.isbn, this.book_name, this.author, this.country, this.genres,
      this.description, this.quantity, this.price, this.available);

  /// Maps without the ID
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'isbn': isbn,
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

  BookModel.fromMap(Map<String, dynamic> map)
      : id =  map['id'],
        isbn = map['isbn'],
        book_name = map['book_name'],
        author = map['author'],
        country = map['country'],
        genres = List<String>.from(map['genres'] ?? []),
        description = map['description'],
        quantity = map['quantity'],
        price = map['price'].toDouble(),
        available = map['available'];
}