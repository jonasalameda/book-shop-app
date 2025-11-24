
class BookDB{
  final CollectionReference books =
  FirebaseFirestore.instance.collection('Books');

  void initializeDB() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyBbuPvGLzeKv0pXmx00hlXySPxT7F8ZQcE",
        appId: "530607033314",
        messagingSenderId: "1:530607033314:android:f0812a8ac5623e81bd47bb",
        projectId: "book-shop-cdfd8",
      ),
    );
  }
}