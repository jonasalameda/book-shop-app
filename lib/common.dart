import 'main.dart';
import 'appBar2.dart';
import 'package:bookshop/controllers/DbController.dart';


Future<void> loadCurrentUser() async {
  // currentUserID = userID;
  if (currentUserID!.isEmpty) return;
  currentUserAppBar = await getUserById(currentUserID!);
}

void unloadCurrentUser(){
  currentUserID = '';
  currentUserAppBar = null;
}