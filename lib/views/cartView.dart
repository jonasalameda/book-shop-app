import 'package:flutter/material.dart';
import 'package:bookshop/appBar.dart';
import 'package:bookshop/models/BookModel.dart';
import 'package:bookshop/models/UserModel.dart';
import 'package:bookshop/controllers/DbController.dart';
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double cartSubtotal = 0;
  double federalTax = 5;
  double provincialTax = 9.975;
  late double totalCart = cartSubtotal * (federalTax + provincialTax);

  List<String> options = ['1', '2', '3', '4', '5',];

  //TODO:get user information from database and store it in variable


  ListTile bookInfoCart(var bookInfo) {
    //TODO:fetch book quantity from db
    int bookQuantity = 0;
    //TODO:fetch book price from db
    double bookPrice = 29.99;
    return ListTile(
      //fetch book info from db
      leading: Image(image: AssetImage('assetName')),
      title: Text('Book Title', style: TextStyle(fontWeight: FontWeight.bold),),
      subtitle: Column(
        children: [
          Text('Author Name', style: TextStyle(fontWeight: FontWeight.w500),),
          SizedBox(height: 15,),
          Container(
              child: Row(children: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        bookQuantity -= 1;
                        cartSubtotal-= bookPrice;
                        if(bookQuantity <= 0){
                          //remove book from cart table in db
                        }
                      });
                    },
                    child: Row(children: [Icon(Icons.delete_forever), Text('Remove'),],)
                ),
                SizedBox(width: 10,),
                TextButton(
                  onPressed: () {
                    setState(() {
                      bookQuantity +=1;
                      cartSubtotal+= bookPrice;
                    });
                  },
                  child: Row(children: [Icon(Icons.add), Text('Add'),]),
                )
              ]))
        ],
      ),
      trailing: Column(
        children: [
          Padding(padding: EdgeInsets.all(2), child:Text(bookQuantity.toString()) ,),
          SizedBox(height: 20,),
          Padding(padding: EdgeInsets.all(2), child:Text(bookPrice.toString()) ,),
        ],
      ),
    );
  }

  //TODO:get books from user cart from db
  late var bookInfo;
  //store Count from db in variable
  int totalBooksInCart = 2;

  loadBooks() {
    return ListView.builder(
        itemBuilder: bookInfoCart(bookInfo);

        // ListView booksInCart = ListView();
        // for(int i = 0; i < totalBooksInCart; i++){
        //   booksInCart.
        // }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(5.5),
              child: Row(
                children: [
                  //Either have a place holder or let users upload an image
                  Image(
                    image: AssetImage('assets/profilePic.jpg'),
                  ),
                  Column(
                    children: [
                      //Import user info from db
                      Text(
                        'First Name, LastName',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('123 Fake Street'),
                      Text('Postal Code'),
                      Text('Montreal, QC')
                    ],
                  )
                ],
              ),
            ),
            //book info Row SHould be a for loop
            Expanded(child: loadBooks()),
          ],
        ),
      ),
    );
  }
}
