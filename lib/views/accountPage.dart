import 'package:bookshop/main.dart';
import 'package:flutter/material.dart';
import 'package:bookshop/appBar.dart';


class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  final String user = currentUserID;

  
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
