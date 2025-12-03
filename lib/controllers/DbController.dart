import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

/// Adds a column from the input reference collection with the inserted newObject.
/// The object must have a toMap function.
/// The function will return false in case of db failure
Future<bool> addRow(CollectionReference collection, newObject) async {
  try {
    await collection.add(newObject.toMap());
    return true;
  } catch (e) {
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
