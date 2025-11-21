/**
 * Here lies all functionalities/back-end logic of User class
 */
class _UserModel {
  int customer_id;
  String first_name;
  String last_name;
  String phone_number;
  String email;
  String password_hash;

  _UserModel(
    this.customer_id,
    this.first_name,
    this.last_name,
    this.phone_number,
    this.email,
    this.password_hash,
  );
}
