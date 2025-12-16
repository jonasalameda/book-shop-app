import 'package:bookshop/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bookshop/appBar2.dart';
import 'package:bookshop/controllers/DbController.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bookshop/common.dart';
import '../l10n/app_localizations.dart';
import 'package:bookshop/models/UserModel.dart';

class DescriptionPage extends StatelessWidget {
  const DescriptionPage({super.key});



  @override
  Widget build(BuildContext context) {

    final item = ModalRoute.of(context)!.settings.arguments as Map;
    // final dbUsers = FirebaseFirestore.instance.collection('Users').snapshots().data![0].docs;

    UserModel user = getUserById(currentUserID!) as UserModel;
    
    

    return Scaffold(
      appBar: buildAppBar(context),
      drawer: customerDrawer(context, 0),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                item['image'].isEmpty
                    ? Image(image: AssetImage('bookPlaceholder.jpg'))
                    : Image(
                  image: NetworkImage(item['image']),
                  width: 300,
                  height: 300,
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(32),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item['name'], style: TextStyle(fontSize: 25, decoration: TextDecoration.underline),),
                      Text("\$${item['price']}", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Author: ${item['author']}"),
                      Text("Stock: ${item['quantity']}"),
                    ],
                  ),
                  Row(
                    children: [
                      // IconButton(
                      //     onPressed: () async {
                      //       //TODO: put current book in cart array instead of wishlist array
                      //       List<dynamic> cartArray =
                      //       currentUser['cart'];
                      //       // cartArray.add(currentBookId);
                      //       // addToCart(widget.userID, usersInfo, currentBookReference);
                      //       await FirebaseFirestore.instance
                      //           .collection('Users')
                      //           .doc(widget.userID)
                      //           .update({
                      //         'cart': FieldValue.arrayUnion(
                      //             [currentBookReference])
                      //       });
                      //       if (cartArray.contains(
                      //           currentBookReference)) {
                      //         showErrorDialog(
                      //             'Item already in cart',
                      //             'It seems like you have already added this item to your cart',
                      //             context,
                      //             'Okay');
                      //       } else {
                      //         showSuccess(
                      //             'Item added Successfully',
                      //             'Item is now in your cart you can checkout',
                      //             context);
                      //       }
                      //     },
                      //     icon: Icon(
                      //       Icons.add_shopping_cart,
                      //       color: Colors.brown,
                      //     )),
                      Text("${user.id ?? 'undefined'}")
                    ],
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
