import 'dart:core';
import 'package:bookshop/models/UserModel.dart';
import 'package:bookshop/models/BookModel.dart';

class _CartModel {
  UserModel customer;
  List<BookModel> orderedBooks;
  double total;
  bool isCheckedOut;

  _CartModel(
      this.customer,
      this.orderedBooks,
      this.total,
      this.isCheckedOut
      );
  Map<String, Object?> toMap() {
    return {
      'customer': customer,
      'orderedBooks': orderedBooks.map((book) => book.toMap()),
      'total': total,
      'isCheckout': isCheckedOut
    };
  }

}


