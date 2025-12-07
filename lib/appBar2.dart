import 'package:flutter/material.dart';
import 'main.dart';

// enum Options {genres, authors, saved, cart, logout}
enum Options { search, myCart, wishList, logout, filter }

var _popUpMenuIndex = 0;
int _selectedIndex = 0;

Color barColor = Color(0xFFAE9674);
//let the App Bar control the height of the menu
var appBarHeight = AppBar().preferredSize.height;

final String title = "";

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: barColor,
    title: const Text(
      'Library Of Ruina',
      style: TextStyle(color: Colors.white, fontSize: 30),
      textAlign: TextAlign.center,
    ),
    leading: Builder(
      builder: (context) {
        return IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: Icon(Icons.menu),
        );
      },
    ),
  );
}
//****************************************************

// void _onItemTapped(int index) {
//   setState(() {
//     _selectedIndex = index;
//   });
// }

Drawer customerDrawer(BuildContext context, int selectedIndex) {
  return Drawer(
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        // const DrawerHeader(
        //   decoration: BoxDecoration(color: Colors.blue),
        //   child: Text('Drawer'),
        // ),
        ListTile(
          title: const Text('Search'),
          selected: selectedIndex == 0,
          onTap: () {
            Navigator.pop(context);
            // Navigator.pushNamed(context, '/logout');
          },
        ),
        ListTile(
          title: const Text('My Cart'),
          selected: selectedIndex == 1,
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/cart');
          },
        ),
        ListTile(
          title: const Text('Account and Wishlist'),
          selected: selectedIndex == 2,
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/account');
          },
        ),
        ListTile(
          title: const Text('Apply Filters'),
          selected: selectedIndex == 3,
          onTap: () {
            Navigator.pop(context);
            // Navigator.pushNamed(context, '/logout');

          },
        ),
        ListTile(
          title: const Text('Logout'),
          selected: selectedIndex == 4,
          onTap: () {
            currentUserID = '';
            Navigator.pop(context);
            Navigator.pushNamed(context, '/login');
          },
        ),
      ],
    ),
  );
}
