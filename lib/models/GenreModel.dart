import 'dart:js_interop_unsafe';

/**
 * Here lies all functionalities/back-end logic of Genre class
 */
class _GenreModel {
  int genre_id;
  String genre_name;

  _GenreModel(this.genre_id, this.genre_name);


  _createGenre(String name_genre){
    //crud operation on Genre table Fire base

  }

  //TODO:update genre seems unnecessary but if it needs to be added it can

  _deleteGenre(int genre_id){
    //pull table from database
    // db.delete(
    //     where id =genre_id)
  }
}
