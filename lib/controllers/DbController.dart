import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvc_application/controller.dart' show ControllerMVC;
// import '../models/BookModel.dart';

Future<void> addColumn(CollectionReference collection, newObject) async {
    await collection.add(newObject.toMap());
}

