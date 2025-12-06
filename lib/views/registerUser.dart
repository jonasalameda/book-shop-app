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

  bool _obscured = true;

  buildRegisterView() {
    var registerColumn = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(50.0),
          child: Container(
            color: Colors.yellow.shade50,
            child: TextField(
              controller: _firstName,
              decoration: InputDecoration(labelText: 'First Name:'),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(50.0),
          child: Container(
            color: Colors.yellow.shade50,
            child: TextField(
              controller: _lastName,
              decoration: InputDecoration(labelText: 'Last Name:'),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(50.0),
          child: Container(
            color: Colors.yellow.shade50,
            child: TextField(
              controller: _phoneNumber,
              decoration: InputDecoration(labelText: 'Phone Number:'),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(50.0),
          child: Container(
            color: Colors.yellow.shade50,
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email:'),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(50.0),
          child: Container(
            color: Colors.yellow.shade50,
            child: TextField(
              controller: _passwordController,
              obscureText: _obscured,
              decoration: InputDecoration(
                labelText: 'Password:',
                icon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscured = !_obscured;
                    });
                  },
                  icon: Icon(Icons.remove_red_eye, color: Colors.brown),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(50.0),
          child: Container(
            color: Colors.yellow.shade50,
            child: TextField(
              controller: _confirmPasswordController,
              obscureText: _obscured,
              decoration: InputDecoration(
                labelText: 'Confirm Password:',
                icon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscured = !_obscured;
                    });
                  },
                  icon: Icon(Icons.remove_red_eye, color: Colors.brown),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 35),
        Row(
          children: [
            SizedBox(width: 30),
            Flexible(
              fit: FlexFit.tight,
              child: ElevatedButton(
                onPressed: () {
                  if (_passwordController.text ==
                      _confirmPasswordController.text) {
                    //TODO: Routse to main products list page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LogInPage()),
                    );
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext builder) {
                          return AlertDialog(
                              title: Text("Passwords must match"),
                              content:
                                  Text('Passwords must match please try again'),
                              actions: [
                                TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: Text('Try again'))
                              ]);
                        });
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.brown.shade500,
                  ),
                ),
                child: Text(
                  'Register',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            TextButton(
              onPressed: () => Navigator.popAndPushNamed(context, '/login'),
              child: Text(
                'Already have an account?',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            SizedBox(width: 40),
          ],
        ),
      ],
    );

    final fName = _firstName.text;
    final lName = _lastName.text;
    final phoneNumber = _phoneNumber.text;
    final email = _emailController.text;
    final password = _confirmPasswordController.text;

    CollectionReference usersCollection = FirebaseFirestore.instance.collection('Users');
    UserModel newUser = new UserModel(fName, lName, phoneNumber, email, password);
    addRow(usersCollection, newUser);

    return registerColumn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Colors.brown.shade200,
      body: Center(
        child: buildRegisterView(),
      ),
    );
  }
}
