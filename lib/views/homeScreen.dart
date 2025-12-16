// import 'package:bookshop/appBar.dart';
import 'package:bookshop/appBar2.dart';
import 'package:bookshop/main.dart';
import 'package:bookshop/views/descriptionPage.dart';
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
        appBar: buildAppBar(context),
        backgroundColor: Color.fromRGBO(219, 206, 206, 1),
        body: SingleChildScrollView(
          child: Center(
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
                        padding: const EdgeInsets.all(0),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/homeTitleDecoration.png"),
                                fit: BoxFit.fitWidth)),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Featured Books",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: EdgeInsetsGeometry.all(8.0),
                  child: _generateFeatured(),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Best Sellers",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                      fontSize: 32),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.all(8),
                  child: _generateFeatured(),
                ),
                const Text(
                  "Our Staff Recommendation",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                      fontSize: 32),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.all(8),
                  child: _generateFeatured(),
                )
              ],
            ),
          ),
        ));
  }
}

Widget? _generateFeatured({String? filter}) {
  return StreamBuilder<List<QuerySnapshot>>(
    // time to use combinedstream from RXdart
    stream: CombineLatestStream.list([
      (filter != null)
          ? FirebaseFirestore.instance
              .collection('Books')
              .orderBy(filter)
              .snapshots()
          : FirebaseFirestore.instance.collection('Books').snapshots(),
    ]),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        print(
            'a todos os agentes da overwatch, aqui é o wintom haha... obviamente');
        return Center(child: CircularProgressIndicator());
      }

      print('roda... viva??');
      var booksData = snapshot.data![0].docs;
      print(booksData.toString());
      //merge into one combined list
      var booksMap = [
        // use spread operator
        ...booksData.map(
          (d) => {
            'id': d.id,
            'name': d['book_name'],
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
      print('maps aqui ooo');
      print(booksMap);
      return Container(
        width: double.infinity,
        height: 200.0,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: booksMap.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) {
            final item = booksMap[i];
            return Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => Descriptionpage()));
                    },
                    child: item['image'].isEmpty
                        ? Image(image: AssetImage('bookPlaceholder.jpg'))
                        : Image(
                            image: NetworkImage(item['image']),
                            width: 100,
                            height: 100,
                          ),
                  ),
                  Text(
                    item['name'] ?? "",
                    style: TextStyle(
                        color:
                            (item['quantity'] > 0) ? Colors.black : Colors.red),
                  ),
                  Text("${item['price']}"),
                  Text("${item['quantity']}"),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
