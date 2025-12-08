import 'package:bookshop/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'controllers/DbController.dart';

// enum Options {genres, authors, saved, cart, logout}
enum Options { search, myCart, wishList, logout, filter, home }

enum AdminOptions { search, books, archive, customers }

var _popUpMenuIndex = 0;
int _selectedIndex = 0;
// final currentUser = getCurrentUser();
// UserModel? currentUser;

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

Drawer customerDrawer(BuildContext context, int selectedIndex) {
  return Drawer(
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        // DrawerHeader(
        //   decoration: BoxDecoration(color: Color(0xFFAE9674)),
        //   child: Row(
        //     children: [
        //       // CircleAvatar(
        //       //   radius: 40,
        //       //   backgroundColor: Colors.transparent,
        //       //   foregroundImage: AssetImage('assets/avatarExample.jpg'),
        //       // ),
        //       currentUser == null
        //           ? CircularProgressIndicator()
        //           :
        //               // leading: Text("${currentUser!.id}"),
        //  Text("${currentUser!.email ?? "unsefined"}"),
        //
        //     ],
        //   ),
        // ),
        DrawerHeader(
          decoration: BoxDecoration(color: Color(0xFFAE9674)),
          child: Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.transparent,
                foregroundImage: AssetImage('assets/avatarExample.jpg'),
              ),
              SizedBox(width: 10),
              // Use Expanded to prevent infinite width
              Expanded(
                child: currentUser == null
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${currentUser!.first_name} ${currentUser!.last_name}",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Text(
                            "${currentUser!.email}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
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
        ListTile(
          title: const Text('Home'),
          selected: selectedIndex == 5,
          onTap: () {
            currentUserID = '';
            Navigator.pop(context);
            Navigator.pushNamed(context, '/home');
          },
        ),
      ],
    ),
  );
}

Drawer adminDrawer(BuildContext context, int selectedIndex) {
  // search, books, archive, customers
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
            currentUser = null;
            Navigator.pop(context);
            Navigator.pushNamed(context, '/login');
          },
        ),
        ListTile(
          title: const Text('Home'),
          selected: selectedIndex == 5,
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/home');
          },
        ),
      ],
    ),
  );
}
