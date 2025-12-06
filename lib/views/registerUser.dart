import 'package:flutter/material.dart';
import 'package:bookshop/appBar.dart';
import 'package:bookshop/views/loginPage.dart';
import 'package:bookshop/controllers/DbController.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bookshop/models/UserModel.dart';

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

  // Validate email format
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
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

    // Validate all fields are filled
    if (fName.isEmpty ||
        lName.isEmpty ||
        phoneNumber.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showErrorDialog('Empty Fields', 'Please fill in all fields');
      return;
    }

    // Validate email format
    if (!_isValidEmail(email)) {
      _showErrorDialog('Invalid Email', 'Please enter a valid email address');
      return;
    }

    // Validate password length
    if (password.length < 6) {
      _showErrorDialog(
          'Weak Password', 'Password must be at least 6 characters long');
      return;
    }

    // Check if passwords match
    if (password != confirmPassword) {
      _showErrorDialog(
          'Passwords must match', 'Passwords must match please try again');
      return;
    }

    // Check if email already exists
    setState(() {
      _isLoading = true;
    });

    try {
      QuerySnapshot existingUser =
      await usersCollection.where('email', isEqualTo: email).limit(1).get();

      if (existingUser.docs.isNotEmpty) {
        setState(() {
          _isLoading = false;
        });
        _showErrorDialog('Email Already Exists',
            'An account with this email already exists. Please login instead.');
        return;
      }

      // Create new user
      UserModel newUser =
      UserModel(fName, lName, phoneNumber, email, password, [], []);

      await addRow(usersCollection, newUser);

      setState(() {
        _isLoading = false;
      });

      // Show success dialog
      _showSuccessDialog();
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorDialog('Registration Error', 'An error occurred: $e');
    }
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Try again'),
            )
          ],
        );
      },
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Registration Successful!'),
          content: Text('Your account has been created. Please login.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.pushReplacementNamed(context, '/login'); // Go to login
              },
              child: Text('Login Now'),
            )
          ],
        );
      },
    );
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