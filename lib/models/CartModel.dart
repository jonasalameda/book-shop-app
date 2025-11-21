/**
 * Here lies all functionalities/back-end logic of Cart class
 */

import 'package:bookshop/models/UserModel.dart';
import 'package:bookshop/models/BookModel.dart';
class _CartModel {
  UserModel customer;
  BookModel book;
  bool isCheckedOut;
}
