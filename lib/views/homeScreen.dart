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
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                    padding: EdgeInsets.all(0),
                    child: Text(
                      "Featured Books",
                      textAlign: TextAlign.center,
                    ),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/dashboardBg.jpg"))),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
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
          },
        ),
      ];
      return ListView.builder(
        shrinkWrap: true,
        itemCount: booksMap.length,
        itemBuilder: (context, i) {
          final item = booksMap[i];
          return StatefulBuilder(
            builder: (context, setState) {
              return CheckboxListTile(
                title: Text(item['name']),
                onChanged: (value) {
                  setState(() {
                    item['done'] = value;
                    FirebaseFirestore.instance
                        .collection('Books')
                        .doc(item['id'])
                        .set(item)
                        .onError((e, _) => item['done'] = value);
                  });
                },
                value: item['done'],
                enableFeedback: true,
                enabled: true,
              );
            },
          );
        },
      );
    },
  );
}
