
class BookDB{

  void initializeDB() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyCjexEQCUZ3OhMj-VyXJcYTV7clWJclu6w",
        appId: "464024739524",
        messagingSenderId: "1:464024739524:android:7bd3f8116a399a5672f391",
        projectId: "library-of-ruina",
      ),
    );
  }
}