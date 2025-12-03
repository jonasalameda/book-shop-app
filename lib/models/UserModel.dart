import 'BookModel.dart';
/**
 * Here lies all functionalities/back-end logic of User class
 */
class UserModel {
  String? customer_id;
  String first_name;
  String last_name;
  String phone_number;
  String email;
  String password_hash;
  List<BookModel>? wishList;
  List<BookModel>? cart;


  UserModel(
      // this.customer_id,
      this.first_name,
      this.last_name,
      this.phone_number,
      this.email,
      this.password_hash,
      // this.wishList,
      // this.cart
      );

  /// Maps without the ID
  Map<String, Object?> toMap() {
    return {
      'first_name': first_name,
      'last_name': last_name,
      'phone_number': phone_number,
      'email': email,
      'password_hash': password_hash,
      'wishList' : wishList,
      'cart' : cart
    };
  }
}
