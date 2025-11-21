/**
 * Here lies all functionalities/back-end logic of Book class
 */
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

  _BookModel(
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
}
