import 'package:bookshop/l10n/app_localizations.dart';
import 'package:bookshop/models/UserModel.dart';
import 'package:bookshop/views/cartView.dart';
import 'package:bookshop/views/homeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'common.dart';
import 'controllers/DbController.dart';
import 'package:bookshop/models/UserModel.dart';
import 'setLocaleMaterialApp.dart';

// enum Options {genres, authors, saved, cart, logout}
enum Options { search, myCart, wishList, logout, filter }

UserModel? currentUserAppBar;

enum AdminOptions { search, books, archive, customers }

var _popUpMenuIndex = 0;
int _selectedIndex = 0;
// final currentUserAppBar = getcurrentUserAppBar();
// UserModel? currentUserAppBar;

Color barColor = Color(0xFFAE9674);
//let the App Bar control the height of the menu
var appBarHeight = AppBar().preferredSize.height;

final String title = "";

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: barColor,
    title: Text(
      AppLocalizations.of(context)!.appTitle,
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
  loadCurrentUser();
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
        //       currentUserAppBar == null
        //           ? CircularProgressIndicator()
        //           :
        //               // leading: Text("${currentUserAppBar!.id}"),
        //  Text("${currentUserAppBar!.email ?? "unsefined"}"),
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
                foregroundImage: AssetImage('assets/profilePlaceHolder.jpg'),
              ),
              SizedBox(width: 10),
              // Use Expanded to prevent infinite width
              Expanded(
                child: currentUserAppBar == null
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${currentUserAppBar!.first_name} ${currentUserAppBar!.last_name}",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Text(
                            "${currentUserAppBar!.email}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
        buildLanguageSwitcher(context),
        ListTile(
          title: Text(AppLocalizations.of(context)!.drawerSearch),
          selected: selectedIndex == 0,
          onTap: () {
            // Navigator.pop(context);

            Navigator.push(
                context, MaterialPageRoute(builder: (builder) => HomeScreen()));
            // Navigator.pushNamed(context, '/logout');
          },
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.drawerCart),
          selected: selectedIndex == 1,
          onTap: () {
            Navigator.pop(context);
            // Navigator.pushNamed(context, '/cart');
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CartPage(userID: currentUserID!)));
          },
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.drawerAccount),
          selected: selectedIndex == 2,
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/account');
          },
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.drawerFilters),
          selected: selectedIndex == 3,
          onTap: () {
            Navigator.pop(context);
            // Navigator.pushNamed(context, '/logout');
          },
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.drawerLogout),
          selected: selectedIndex == 4,
          onTap: () {
            unloadCurrentUser();
            Navigator.pop(context);
            Navigator.pushNamed(context, '/login');
          },
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.drawerFindUs),
          selected: selectedIndex == 5,
          onTap: () {
            unloadCurrentUser();
            Navigator.pop(context);
            Navigator.pushNamed(context, '/map');
          },
        ),

        ListTile(
          title: Text("Home"),
          selected: selectedIndex == 6,
          onTap: () {
            unloadCurrentUser();
            Navigator.pop(context);
            Navigator.pushNamed(context, '/home');
          },
        ),
      ],
    ),
  );
}

//enum AdminOptions { search, books, archive, customers }

Drawer adminDrawer(BuildContext context, int selectedIndex) {
  // search, books, archive, customers
  return Drawer(
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        buildLanguageSwitcher(context),
        // const DrawerHeader(
        //   decoration: BoxDecoration(color: Colors.blue),
        //   child: Text('Drawer'),
        // ),
        DrawerHeader(
          decoration: BoxDecoration(color: Color(0xFFAE9674)),
          child: Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.transparent,
                foregroundImage: AssetImage('assets/profilePlaceHolder.jpg'),
              ),
              SizedBox(width: 10),
              // Use Expanded to prevent infinite width
              Expanded(
                child: currentUserAppBar == null
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${currentUserAppBar!.first_name} ${currentUserAppBar!.last_name}",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Text(
                            "${currentUserAppBar!.email}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.drawerSearch),
          selected: selectedIndex == 0,
          onTap: () {
            Navigator.pop(context);
            // Navigator.pushNamed(context, '/admin');
          },
        ),
        ListTile(
          title: Text('Admin'),
          selected: selectedIndex == 1,
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/admin');
          },
        ),
        ListTile(
          title: const Text('Customers'),
          selected: selectedIndex == 2,
          onTap: () {
            Navigator.pop(context);
            // Navigator.pushNamed(context, '/account');
          },
        ),

        ListTile(
          title: Text(AppLocalizations.of(context)!.drawerLogout),
          selected: selectedIndex == 3,
          onTap: () {
            currentUserID = '';
            currentUserAppBar = null;
            Navigator.pop(context);
            Navigator.pushNamed(context, '/login');
          },
        ),

        ListTile(
          title: Text(AppLocalizations.of(context)!.drawerFindUs),
          selected: selectedIndex == 4,
          onTap: () {
            currentUserID = '';
            currentUserAppBar = null;
            Navigator.pop(context);
            Navigator.pushNamed(context, '/map');
          },
        ),
      ],
    ),
  );
}
