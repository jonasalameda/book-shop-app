import 'package:bookshop/l10n/app_localizations.dart';
import 'package:bookshop/models/UserModel.dart';
import 'main.dart';
import 'appBar2.dart';
import 'package:bookshop/controllers/DbController.dart';
import 'package:flutter/material.dart';
import 'package:bookshop/views/paymentPage.dart';

UserModel? currentUser;

String? currentUserID;

List<Map<String, dynamic>> allUsers = [];
List<Map<String, dynamic>> allBooks = [];

Future<void> loadCurrentUser() async {
  // currentUserID = userID;
  if (currentUserID == null) return;

  currentUser = await getUserById(currentUserID!);
}


void unloadCurrentUser() {
  currentUser = null;
  currentUserID = null;
  currentUserAppBar = null;
}

showErrorDialog(String error, String message, BuildContext context,
    [String textbutton = 'Try Again']) {
  showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          title: Text(error),
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(textbutton)),
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
            child: Text(AppLocalizations.of(context)!.loginBtn),
          )
        ],
      );
    },
  );
}

void showSuccess(String title, String message, BuildContext context,
    [String textbutton = 'okay']) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
            },
            child: Text(textbutton),
          )
        ],
      );
    },
  );
}

void showSuccessPayment(
    String title, String message, BuildContext context, double totalcart) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PaymentPage(
                          totalPayment: totalcart))); // Close dialog
            },
            child: Text(AppLocalizations.of(context)!.cartPayment),
          )
        ],
      );
    },
  );
}
