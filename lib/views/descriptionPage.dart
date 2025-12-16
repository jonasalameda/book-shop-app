import 'package:flutter/material.dart';
import 'package:bookshop/main.dart';
import 'package:bookshop/appBar2.dart';

class DescriptionPage extends StatelessWidget {
  const DescriptionPage({super.key});


  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as Map;

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
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
