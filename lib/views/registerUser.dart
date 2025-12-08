import 'package:flutter/material.dart';
import 'package:bookshop/appBar.dart';
import 'package:bookshop/views/loginPage.dart';
import 'package:bookshop/controllers/DbController.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bookshop/models/UserModel.dart';
import 'package:bookshop/controllers/UserController.dart';
import 'package:bookshop/common.dart';

class RegisterUserPage extends StatefulWidget {
  const RegisterUserPage({super.key});

  @override
  State<RegisterUserPage> createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscuredPassword = true;
  bool _obscuredConfirm = true;
  bool _isLoading = false;

  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('Users');

  //i put it in register because i its the only time we need to validate
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return emailRegex.hasMatch(email.trim());
  }

  bool _isValidPhone(String phone){
    final phoneRegex = RegExp(r'^[0-9]{3}-[0-9]{3}-[0-9]{4}$');
    return phoneRegex.hasMatch(phone.trim());
  }

  // Handle registration
  Future<void> _handleRegister() async {
    // Get values from controllers
    final fName = _firstName.text.trim();
    final lName = _lastName.text.trim();
    final phoneNumber = _phoneNumber.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    // make sure nothing is empty
    if (fName.isEmpty ||
        lName.isEmpty ||
        phoneNumber.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      showErrorDialog('Empty Fields', 'Please fill in all fields', context);
      return;
    }

    // check email is valid
    if (!_isValidEmail(email)) {
      showErrorDialog('Invalid Email', 'Please enter a valid email address', context);
      return;
    }
    //check if phone is put correctly
    if (!_isValidPhone(phoneNumber)) {
      showErrorDialog('Invalid Phone Format', 'Please enter your phone number in this format: 123-123-1234', context);
      return;
    }

    if (password.length < 8) {
      showErrorDialog(
          'Weak Password', 'Password must be at least 8 characters long', context);
      return;
    }

    // passwords have to be the same
    if (password != confirmPassword) {
      showErrorDialog(
          'Passwords must match', 'Passwords must match please check and try again', context);
      return;
    }

    // if email exists reject adding the customer
    setState(() {
      _isLoading = true;
    });

    try {
      var existingUser =
      await usersCollection.where('email', isEqualTo: email).limit(1).get();

      if (existingUser.docs.isNotEmpty) {
        setState(() {
          _isLoading = false;
        });
        showErrorDialog('Email Already Exists',
            'An account with this email already exists. Please login instead.', context);
        return;
      }

      // Add a new customer
      String addingSuccess = await Usercontroller().addCustomer(fName, lName, phoneNumber, email, password);
       if(addingSuccess.isEmpty){ //if empty registration is successful
         setState(() {
           _isLoading = false;
         });
         // show that registration was successfull
         showSuccessDialog(context);
       }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      showErrorDialog('Registration Error', 'An error occurred: $e', context);
    }
  }
  @override
  void dispose() {
    // Clean up controllers
    _firstName.dispose();
    _lastName.dispose();
    _phoneNumber.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Colors.brown.shade200,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade50,
                      borderRadius:  BorderRadius.circular(10)
                    ),
                    child: TextField(
                      controller: _firstName,
                      decoration: InputDecoration(
                        labelText: 'First Name:',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(10),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.yellow.shade50,
                        borderRadius:  BorderRadius.circular(10)
                    ),                    child: TextField(
                      controller: _lastName,
                      decoration: InputDecoration(
                        labelText: 'Last Name:',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(10),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.yellow.shade50,
                        borderRadius:  BorderRadius.circular(10)
                    ),                    child: TextField(
                      controller: _phoneNumber,
                      decoration: InputDecoration(
                        labelText: 'Phone Number:',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(10),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.yellow.shade50,
                        borderRadius:  BorderRadius.circular(10)
                    ),                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email:',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(10),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.yellow.shade50,
                        borderRadius:  BorderRadius.circular(10)
                    ),                    child: TextField(
                      controller: _passwordController,
                      obscureText: _obscuredPassword,
                      decoration: InputDecoration(
                        labelText: 'Password:',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(10),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscuredPassword = !_obscuredPassword;
                            });
                          },
                          icon: Icon(
                            _obscuredPassword ? Icons.visibility : Icons.visibility_off,
                            color: Colors.brown,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.yellow.shade50,
                        borderRadius:  BorderRadius.circular(10)
                    ),                    child: TextField(
                      controller: _confirmPasswordController,
                      obscureText: _obscuredConfirm,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password:',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(10),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscuredConfirm = !_obscuredConfirm;
                            });
                          },
                          icon: Icon(
                            _obscuredConfirm ? Icons.visibility : Icons.visibility_off,
                            color: Colors.brown,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 35),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleRegister,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.brown.shade500,
                        ),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                      child: _isLoading
                          ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                          : Text(
                        'Register',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                  child: Text(
                    'Already have an account?',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}