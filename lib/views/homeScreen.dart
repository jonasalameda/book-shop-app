import 'package:bookshop/appBar.dart';
import 'package:bookshop/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/streams.dart';

const FEATURED_BOOKS_LIMIT = 6;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                    padding: EdgeInsets.all(0),
                    child: Image.asset('assets/dashboardBg.jpg'),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: Container(
                    width: 500,
                    height: 110,
                    padding: EdgeInsets.all(0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Featured Books",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/homeTitleDecoration.png"),
                            fit: BoxFit.fitWidth)),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),

            Row(
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.all(8.0),
                  child: _generateFeatured(),
                )
              ],
            )
            // ListView.builder(
            //   shrinkWrap: true,
            //   scrollDirection: Axis.horizontal,
            //     itemCount: FEATURED_BOOKS_LIMIT,
            //     itemBuilder: (builder, index) {

            //     })
          ],
        ),
      ),
    );
  }
}

Widget? _generateFeatured() {
  StreamBuilder<List<QuerySnapshot>>(
    // time to use combinedstream from RXdart
    stream: CombineLatestStream.list([
      FirebaseFirestore.instance
          .collection('Books')
          .orderBy("name")
          .snapshots(),
    ]),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return Center(child: CircularProgressIndicator());
      }
      var booksData = snapshot.data![0].docs;

      //merge into one combined list
      var booksMap = [
        // use spread operator
        ...booksData.map(
          (d) => {
            'id': d.id,
            'name': d['name'],
            'author': d['author'],
            'available': d['available'],
            'country': d['country'],
            'description': d['description'],
            'genres': d['genres'],
            'price': d['price'],
            'quantity': d['quantity'],
            'image': d['image'] ?? '',
          },
        ),
      ];

      print(booksMap);
      return ListView.builder(
        shrinkWrap: true,
        itemCount: FEATURED_BOOKS_LIMIT,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) {
          final item = booksMap[i];
          return Card(
            shadowColor: Colors.black,
            child: Column(
              children: [
                // booksMap['image'].isEmpty
                // ? Image(image: AssetImage('bookPlaceholder.jpg'))
                // : Image(image: NetworkImage(booksMap['image']))
              ],
            ),
            semanticContainer: false,
          );
        },
      );
    },
  );
}
