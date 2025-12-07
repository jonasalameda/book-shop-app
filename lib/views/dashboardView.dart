import 'package:flutter/material.dart';
import 'package:bookshop/appBar2.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 5;

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
