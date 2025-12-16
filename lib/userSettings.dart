import 'package:flutter/material.dart';

Color appBarBg = const Color.fromARGB(255, 218, 200, 196);
Color appBarText = Colors.white;
Color bodyBG = Colors.brown.shade500.withAlpha(150);

changeColorTheme(bool isLight) {
  if (isLight) {
    appBarBg = Colors.brown.shade100;
    appBarText = Colors.brown.shade900;
    bodyBG = Colors.orange.shade300.withAlpha(100);
  } else {
    appBarBg = Colors.brown.shade800;
    appBarText = Colors.white;
    bodyBG = Colors.brown.shade500.withAlpha(150);
  }

  return !isLight;
}

Color getAppBarBG() {
  return appBarBg;
}

Color getAppBarText() {
  return appBarText;
}

Color getBGColor() {
  return bodyBG;
}

@override
Widget build(BuildContext context) {
  return Scaffold();
}
