// import 'package:firebase_core/firebase_core.dart';
import 'package:bookshop/controllers/DbController.dart';
import 'package:bookshop/views/googleMap.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bookshop/views/loginpage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// import 'package:bookshop/controllers/DbController.dart';
import 'common.dart';
import 'package:bookshop/views/registerUser.dart';
import 'package:bookshop/views/accountView.dart';
import 'package:bookshop/views/adminView.dart';
import 'package:bookshop/views/cartView.dart';
import 'package:bookshop/views/dashboardView.dart';
import 'package:bookshop/views/descriptionPage.dart';
import 'package:bookshop/views/splashScreen.dart';
import 'l10n/app_localizations.dart';
import 'main.dart';

Locale _locale = const Locale('en');

Widget buildMaterialApp(BuildContext context) {
  return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ruina Book Store',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown.shade400),
      ),
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
        Locale('fr'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => LogInPage(),
        '/home': (context) => DashboardPage(),
        '/registerUser': (context) => RegisterUserPage(),
        // '/admin': (context) => AdminPage(userID: 'cpWtMJprI1mqtNey7XGf',), //Only one admin, so we hard-code
        '/admin': (context) => AdminPage(
              userID: '',
            ),
        //customer: Xzw3cOOpQJ2DFSTKHQh2  - admin: cpWtMJprI1mqtNey7XGf
        '/account': (context) => AccountPage(
              userID: currentUserID!,
            ),
        '/cart': (context) => CartPage(
              userID: currentUserID!,
            ),
        '/map': (context) => MapPage(),
        '/description': (context) => DescriptionPage(),
        // add more routes as needed
      });
}

Widget buildLanguageSwitcher(BuildContext context) {
  return ValueListenableBuilder<Locale>(
      valueListenable: localeNotifier,
      builder: (context, locale, child) {
        return DropdownButton<Locale>(
          value: Localizations.localeOf(context),
          items: [
            DropdownMenuItem(value: Locale('en'), child: Text("English")),
            DropdownMenuItem(value: Locale('fr'), child: Text("Francais")),
          ],
          onChanged: (newLocale) {
            setLocale(newLocale!);
          },
        );
      });
}

final ValueNotifier<Locale> localeNotifier = ValueNotifier(const Locale('en'));

void setLocale(Locale newLocale) {
  _locale = newLocale;
  localeNotifier.value = newLocale;
}
