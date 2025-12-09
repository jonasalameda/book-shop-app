import 'package:bookshop/controllers/DbController.dart';
import 'package:bookshop/main.dart';
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
  void initState() {
    super.initState();
    _initUser();
  }

  Future<void> _initUser() async {
    if (currentUserID.isNotEmpty) {
      currentUser = await getUserById(currentUserID);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: const Color.fromARGB(255, 104, 87, 61),
      body: Center(
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/loginPageBg.jpg"),
                fit: BoxFit.fitHeight),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FilledButton(
                  onPressed: () {
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (builder) => LogInPage()));
                    Navigator.of(context).pushNamed("/login");
                  },
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          Color.fromRGBO(140, 118, 83, 1.0)),
                      fixedSize: WidgetStatePropertyAll(Size(200, 65)),
                      enableFeedback: true),
                  child: const Text("Log in")),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "New to Ruina? ",
                    style: TextStyle(color: Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.all(0),
                    child: Text(
                      "Create an Account",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 70,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
