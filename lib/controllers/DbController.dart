import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bookshop/models/UserModel.dart';

//TODO: Initialize all collections/tables
class BookDB {
  late final CollectionReference books =
      FirebaseFirestore.instance.collection('Books');
  late final CollectionReference users =
      FirebaseFirestore.instance.collection('Users');
  late final CollectionReference cart =
      FirebaseFirestore.instance.collection('Cart');

  void initializeDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBbuPvGLzeKv0pXmx00hlXySPxT7F8ZQcE",
        appId: "530607033314",
        messagingSenderId: "1:530607033314:android:f0812a8ac5623e81bd47bb",
        projectId: "book-shop-cdfd8",
      ),
    );
  }
}

Future<List> getTableList(String tableName) async {
  try {
    final tableData =
        await FirebaseFirestore.instance.collection(tableName).get();
    return tableData.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  } catch (e) {
    throw Exception(e.toString());
  }
}

updateElement(CollectionReference collection, String id, String elementName,
    dynamic elementToChange) async {
  await collection.doc(id).update({elementName: elementToChange});
}

getUser(List users, String wantedUser) {
  for (int i = 0; i < users.length; i++) {
    if (users[i]['id'] == (wantedUser)) {
      return users[i];
    }
  }
  // return await usersList.doc(widget.userID).get();
}

String? findUser(List users, String email) {
  for (int i = 0; i < users.length; i++) {
    if (users[i]['email'] == (email)) {
      return users[i]['id'];
    }
  }
  return null;
}

getBook(List books, String bookId) {
  for (int i = 0; i < books.length; i++) {
    if (books[i]['id'] == (bookId)) {
      return books[i];
    }
  }
  // return null;
}

/// Adds a column from the input reference collection with the inserted newObject.
/// The object must have a toMap function.
/// The function will return false in case of db failure
Future<bool> addRow(CollectionReference collection, newObject) async {
  try {
    await collection.add(newObject.toMap());
    return true;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

/// Deletes a column from the input reference collection where the id matches.
/// The function will return false in case of db failure.
Future<bool> deleteRow(String id, CollectionReference collection) async {
  try {
    await collection.doc(id).delete();
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> updateRow(
    String id, CollectionReference collection, updatedObject) async {
  try {
    await collection.doc(id).update(updatedObject.toMap());
    return true;
  } catch (e) {
    return false;
  }
}

Future<UserModel?> getUserById(String userId) async {
  try {
    final doc =
        await FirebaseFirestore.instance.collection('Users').doc(userId).get();
    if (!doc.exists) return null;
    return UserModel.fromMap(doc.data()!, doc.id);
  } catch (e) {
    print("Error fetching user: $e");
    return null;
  }
}

Future<UserModel?> getUserByEmail(String email) async {
  try {
    final query = await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    if (query.docs.isEmpty) return null;
    final doc = query.docs.first;
    return UserModel.fromMap(doc.data(), doc.id);
  } catch (e) {
    print("Error fetching user by email: $e");
    return null;
  }
}
