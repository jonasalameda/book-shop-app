import 'package:bookshop/models/UserModel.dart';
import 'package:bookshop/controllers/DbController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:mvc_application/controller.dart' show ControllerMVC;
// import 'package:email_validator/email_validator.dart';

/// BookController communicates with the view to render logic on the code
class _Usercontroller {


  /// Checks all fields and hashes the password, then inserts in database
  /// It will return the error message if the input has problem,
  /// or it will return an empty string if the operation is successful
  Future<String> addCustomer(String first_name, String last_name,
      String phone_number, String email, String password) async
  {
    final phoneRegex = RegExp(r'^[0-9]{3}-[0-9]{3}-[0-9]{4}$');
    // final emailRegex = ; //Use email_validator
    final emailRegex = RegExp(r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    // List<String> errors = [];

    if(first_name.isEmpty || last_name.isEmpty || phone_number.isEmpty || email.isEmpty || password.isEmpty) {
      return "Please fill the form completely.";
    }
    if(password.length < 8) { // we can add more security for psw later
      return "Your password must be at least 8 characters";
    }
    if(!phoneRegex.hasMatch(phone_number.trim())) {
      return "Please enter your phone number in this format: 123-123-1234";
    }
    if(!emailRegex.hasMatch(email.trim())) {
      return "Please enter a correct email like abc@example.com";
    }

    //Define the ID later
    //Empty wishlist
    //TODO hash the psw
    UserModel newUser = new UserModel(0, first_name, last_name, phone_number, email, password, [], []);
    CollectionReference users = FirebaseFirestore.instance.collection('Users');

    try{
      await addRow(users, newUser);
    } catch(e) {
      return "Db failure to add the user!";
    }
    return ""; // Empty string means success
  }


}
