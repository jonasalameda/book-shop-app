import 'package:flutter/material.dart';
import 'package:bookshop/appBar2.dart';

class AdminCustomersPage extends StatefulWidget {
  const AdminCustomersPage({super.key});

  @override
  State<AdminCustomersPage> createState() => _AdminCustomersPageState();
}

class _AdminCustomersPageState extends State<AdminCustomersPage> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFAE9674),
      appBar: buildAppBar(context),
      drawer: adminDrawer(context, _selectedIndex),
      body:
      Column(
        children: [
            
        ],
      ),
    );
  }
}
