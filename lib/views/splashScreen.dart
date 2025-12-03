import 'package:bookshop/views/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:bookshop/appBar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Color.fromARGB(255, 104, 87, 61),
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("asset/loginPageDb.jpg")),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FilledButton(
                  onPressed: () {
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (builder) => LogInPage()));
                    Navigator.of(context).pushNamed("/login");
                  },
                  child: Text("Log in")),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text("New to Ruina?"),
                  Padding(
                    padding: EdgeInsetsGeometry.all(0),
                    child: Text(
                      "Create an Account",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 70,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
