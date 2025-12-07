import 'package:flutter/material.dart';
import 'package:bookshop/appBar2.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFAE9674),
      appBar: buildAppBar(context),
      drawer: customerDrawer(context, _selectedIndex),
      body:
      Column(
        children: [
        ],
      ),
    );
  }
}
