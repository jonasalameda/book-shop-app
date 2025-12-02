import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bookshop/appBar.dart';
import 'package:bookshop/models/BookModel.dart';
import 'package:bookshop/models/UserModel.dart';
import 'package:bookshop/controllers/DbController.dart';
import 'package:rxdart/rxdart.dart';


class CartPage extends StatefulWidget {
  final String userID;
  const CartPage({Key? key, required this.userID}) : super(key : key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late var booksInCart;
  double cartSubtotal = 0;
  double federalTax = 5/100;
  double provincialTax = 9.975/100;
  late double totalCart = cartSubtotal * (federalTax + provincialTax);

  List<String> options = ['1', '2', '3', '4', '5',];



  void initState() {
    super.initState();
    getTableList('cart').then((results) {
      setState(() {
        userItems = results;
      });
    });
  }


  loadBooks() {
   return Expanded(child: Padding(padding: EdgeInsets.all(10),
   child: StreamBuilder<List<QuerySnapshot>>(
     stream: CombineLatestStream.list([
       FirebaseFirestore.instance.collection('Users').snapshots(),
       FirebaseFirestore.instance.collection('Books').snapshots()
     ]),
     builder: (context, snapshot){
       var dbUsers = snapshot.data![0].docs;
       var dbBooks = snapshot.data![1].docs;
       
       var usersInfo = [
         ...dbUsers.map((usr) => {
           'id': usr.id,
           'first_name': usr['first_name'],
           'last_name': usr['last_name'],
           'phone_number': usr['phone_number'],
           'email': usr['email'],
           'password_hash': usr['password_hash'],
           'wishList': usr['wishList'],
           'cart': usr['cart'],
           'type': 'user'
         })
       ];


       var booksInfo = [
         ...dbBooks.map((book) => {
           'id': book.id,
           'isbn': book['isbn'],
           'book_name': book['book_name'],
           'author': book['author'],
           'country': book['country'],
           'genres': book['genres'],
           'description': book['description'],
           'quantity': book['quantity'],
           'price': book['price'],
           'available': book['available'],
           'type': 'book'
         }),
       ];

       var currentUser = getUser(usersInfo, widget.userID);
   }
   ),
   ),
    );
    }

  //TODO:get user information from database and store it in variable
  ListTile bookInfoCart() {
    booksInCart = userItems['cart'];
    int j = 0;
    int bookQuantity =0;
    int total = booksInCart.lenght;
    // book = booksInCart[j];
    var bookInfo = FirebaseFirestore.instance.collection('Books').doc(booksInCart[j]).get();


    //TODO:fetch book quantity from db
    // int bookQuantity = bookInfo['quantity'];
    //TODO:fetch book price from db
    double bookPrice = 29.99;
    return ListTile(
      //TODO: fetch book link info from db
      leading: Image(image: AssetImage('assetName')),
      title: Text(userItems['cart'][booksInCart][''], style: TextStyle(fontWeight: FontWeight.bold),),
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
                        cartSubtotal -= bookPrice;
                        if (bookQuantity <= 0) {
                          //remove book from cart table in db
                        }
                      });
                    },
                    child: Row(
                      children: [Icon(Icons.delete_forever), Text('Remove'),],)
                ),
                SizedBox(width: 10,),
                TextButton(
                  onPressed: () {
                    setState(() {
                      bookQuantity += 1;
                      cartSubtotal += bookPrice;
                    });
                  },
                  child: Row(children: [Icon(Icons.add), Text('Add'),]),
                )
              ]))
        ],
      ),
      trailing: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(2), child: Text(bookQuantity.toString()),),
          SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.all(2), child: Text(bookPrice.toString()),),
        ],
      ),
    );
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
                      Text(userItems['first_name']),
                      Text('Postal Code'),
                      Text('Montreal, QC')
                    ],
                  )
                ],
              ),
            ),
            //book info Row SHould be a for loop
            // Expanded(child: loadBooks()),
          ],
        ),
      ),
    );
  }
}
