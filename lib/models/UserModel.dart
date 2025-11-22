/**
 * Here lies all functionalities/back-end logic of User class
 */
class UserModel {
  String first_name;
  String last_name;
  String phone_number;
  String email;
  String password_hash;
  List<String> wishlist;
  String role;

  UserModel(
    this.first_name,
    this.last_name,
    this.phone_number,
    this.email,
    this.password_hash,
    this.wishlist, [
    this.role = "customer",
  ]);
}
