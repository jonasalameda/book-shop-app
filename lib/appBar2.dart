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
setCurrentUser() async{
  currentUserAppBar = await getUserById(currentUserID!);
}

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

_updateUser(userId, BuildContext context)
{
  return showDialog(
    context: context,
    builder: (context) {
      Map<String, dynamic> newData = {};
      String newfname = '';
      String newlname = '';
      String newEmail= '';
      String newPhone= '';

      return AlertDialog(
        title: const Text("Update Information"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                onChanged: (value) => newfname = value,
                decoration:
                InputDecoration(hintText: 'Enter new first name'),
              ),
              TextField(
                onChanged: (value) => newlname = value,
                decoration:
                InputDecoration(hintText: 'Enter new last name'),
              ),
              TextField(
                onChanged: (value) => newEmail = value,
                decoration:
                InputDecoration(hintText: 'Enter new email'),
              ),
              TextField(
                onChanged: (value) => newPhone = value,
                decoration:
                InputDecoration(hintText: 'Enter new phone'),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
              onPressed: () async {
                final emailRegex = RegExp(
                    r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

                final phoneRegex = RegExp(r'^[0-9]{3}-[0-9]{3}-[0-9]{4}$');

                if (newfname.trim().isNotEmpty) {
                  newData['first_name'] = newfname.trim();
                  currentUserAppBar!.first_name = newData['first_name'];
                }
                if (newlname.trim().isNotEmpty) {
                  newData['last_name'] = newlname.trim();
                  currentUserAppBar!.last_name = newData['last_name'];
                }
                if (newEmail.trim().isNotEmpty && emailRegex.hasMatch(newEmail.trim())) {
                  newData['email'] = newEmail.trim();
                  currentUserAppBar!.email = newData['email'];
                }
                if (newPhone.trim().isNotEmpty && phoneRegex.hasMatch(newPhone.trim())) {
                  newData['phone_number'] = newPhone.trim();
                  currentUserAppBar!.phone_number = newData['phone_number'];
                }

                if (newData.isNotEmpty) {
                  await updateUser(userId, newData);
                } else {
                  showErrorDialog("Could not update!","Make sure the email is valid and the phone number should be in the format 123-123-1234 if needs to be updated.", context); //general function from main
                }
                // await loadCurrentUser();
                Navigator.pop(context);
              },
              child: Text("Update")),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'))
        ],
      );
    },
  );
}

Drawer customerDrawer(BuildContext context, int selectedIndex) {
  return Drawer(
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        Text(currentUserAppBar.toString()),
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
                    IconButton(
                        onPressed: () async{
                          await _updateUser(currentUserID, context);
                          Navigator.pop(context);

                          Navigator.pushNamed(context, '/account');
                        }, icon: Icon(Icons.edit))
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

            // Navigator.push(
            //     context, MaterialPageRoute(builder: (builder) => HomeScreen()));
            Navigator.pop(context);
            Navigator.pushNamed(context, '/library');
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
            Navigator.pop(context);
            Navigator.pushNamed(context, '/map');
          },
        ),
        ListTile(
          title: Text("Home"),
          selected: selectedIndex == 6,
          onTap: () {
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
                    IconButton(
                        onPressed: () async{
                          await _updateUser(currentUserID, context);
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/admin');
                        }, icon: Icon(Icons.edit))
                  ],
                ),
              ),
            ],
          ),
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
            unloadCurrentUser();
            Navigator.pop(context);
            Navigator.pushNamed(context, '/login');
          },
        ),
      ],
    ),
  );
}