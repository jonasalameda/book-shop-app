import 'package:flutter/material.dart';
import 'package:bookshop/appBar.dart';
import 'package:bookshop/views/loginPage.dart';

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

  bool _obscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Colors.brown.shade200,
      body: Center(
        child: Column(
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
            SizedBox(height: 35),
            Row(
              children: [
                SizedBox(width: 30),
                Flexible(
                  fit: FlexFit.tight,
                  child: ElevatedButton(
                    onPressed: () {
                      //TODO: Routse to main products list page
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
                  onPressed: () =>Navigator.popAndPushNamed(context, '/login'),
                  child: Text(
                    'Already have an account?', style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                SizedBox(width: 40),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
