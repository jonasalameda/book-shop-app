import 'package:flutter/material.dart';
import 'package:bookshop/appBar2.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _selectedIndex = 0;

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
