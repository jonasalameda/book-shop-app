import 'main.dart';
import 'appBar2.dart';
import 'package:bookshop/controllers/DbController.dart';
import 'package:flutter/material.dart';

Future<void> loadCurrentUser() async {
  // currentUserID = userID;
  if (currentUserID == null) return;
  currentUserAppBar = await getUserById(currentUserID!);
}

void unloadCurrentUser() {
  currentUserID = '';
  currentUserAppBar = null;
}

showErrorDialog(String error, String message, BuildContext context) {
  showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          title: Text(error),
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Try Again"))
          ],
        );
      });
}

void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Registration Successful!'),
        content: Text('Your account has been created. Please login.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.pushReplacementNamed(context, '/login'); // Go to login
            },
            child: Text('Login Now'),
          )
        ],
      );
    },
  );
}
