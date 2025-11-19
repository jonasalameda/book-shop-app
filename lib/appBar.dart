import 'package:flutter/material.dart';

enum Options{search, myCart, wishList, logout, filter}

var _popUpMenuIndex = 0;
//let the App Bar control the height of the menu
var appBarHeight = AppBar().preferredSize.height;

//lets build the appBar container

AppBar buildAppBar(){
  return AppBar(
    title: Text('Library Of Ruina',
      style: TextStyle(color: Colors.white, fontSize: 30),
    ),
    backgroundColor: Colors.brown.shade900,
    actions: [
      PopupMenuButton(
        onSelected: (value){
          _onMenuItemsSelected(value as int);
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.0),
                topLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
                topRight: Radius.circular(8.0)
            )
        ),
        itemBuilder: (context) => [
          _buildPopUpItem('Search', Icons.search, Options.search.index),
          _buildPopUpItem('Filter', Icons.filter_alt_outlined, Options.filter.index),
          _buildPopUpItem('My saved', Icons.favorite, Options.wishList.index),
          _buildPopUpItem('My cart', Icons.shopping_cart, Options.myCart.index),
          _buildPopUpItem('Log Out', Icons.exit_to_app, Options.logout.index),
        ],
      )
    ],
  );
}

PopupMenuItem _buildPopUpItem(String text, IconData iconData, int position){
  return PopupMenuItem(
    value: position,
    child: Row(
      children: [
        Icon(iconData, color: Colors.brown,),
        Text(text),
      ],
    ),
  );
}


//TODO: import page routes from files for item selection
_onMenuItemsSelected(int value){
  _popUpMenuIndex = value;

  if(value ==  Options.search.index){
    //change page to found value
  } else if(value ==  Options.filter.index){
    //filer method and refresh page
  }  else if(value ==  Options.wishList.index){
    //change page to saved books
  }  else if(value ==  Options.myCart.index){
    //switch to cart page
  } else if(value ==  Options.logout.index){
    //pop page and go back to splash screen
  }
}