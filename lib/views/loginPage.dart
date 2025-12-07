import 'package:flutter/material.dart';
import 'package:bookshop/appBar.dart';
import 'package:bookshop/views/registerUser.dart';
import 'package:bookshop/main.dart';
import 'package:bookshop/controllers/DbController.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscured = true;

  @override
  void initState() {
    super.initState();
    _initUser();
  }

  Future<void> _initUser() async {
    if(currentUserID.isNotEmpty) {
      currentUser = await getUserById(currentUserID);
    }
  }

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
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Password:'),
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
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                // Text('New to Ruina?', style: TextStyle(color: Colors.white, fontSize: 20),),
                  TextButton(
                    onPressed: () =>Navigator.popAndPushNamed(context, '/registerUser'),
                    child: Text(
                      'New to Ruina?', style: TextStyle(color: Colors.white, fontSize: 20),
                      // 'Create an Account',
                      // style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
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
