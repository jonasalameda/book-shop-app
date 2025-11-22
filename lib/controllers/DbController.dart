import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvc_application/controller.dart' show ControllerMVC;
// import '../models/BookModel.dart';

/// Adds a column from the input reference collection with the inserted newObject.
/// The object must have a toMap function.
/// The function will return false in case of db failure
Future<bool> addColumn(CollectionReference collection, newObject) async {
    try {
        await collection.add(newObject.toMap());
        return true;
    } catch(e) {
        return false;
    }
}

/// Deletes a column from the input reference collection where the id matches.
/// The function will return false in case of db failure.
Future<bool> deleteColumn(String id, CollectionReference collection) async {
    try {
        await collection.doc(id).delete();
        return true;
    } catch(e) {
        return false;
    }
}

