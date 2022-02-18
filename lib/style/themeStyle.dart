import 'package:flutter/material.dart';

Color hexToColor(int rgb) => Color(0xFF000000 + rgb);
final Color primaryColor = Color(0xFFf4c62c);
final Color secondColor = Color(0xFFc9c99a);
final Color darkColor = hexToColor(0x262d37);
final Color colorOne = Color(0xFF34d692);
final Color colorTwo = Color(0xFF34d692).withOpacity(0.6);
final Color colorThree = Color(0xFF34d692).withOpacity(0.3);

const TextStyle styleMenu = TextStyle(
    fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFc9c99a));
const TextStyle styleTitleOn = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
);
const TextStyle ratingList =
    TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white);
const TextStyle styleTitleMore =
    TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold);
const TextStyle styleTitleList =
    TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
const TextStyle styleAttrList = TextStyle(fontSize: 14);
const TextStyle styleColorEps = TextStyle(fontSize: 12, color: Colors.white);
const TextStyle titleList =
    TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
const TextStyle detailStyle = TextStyle(fontSize: 14);
const TextStyle prevnextStyle = TextStyle(fontSize: 12, color: Colors.white);
const TextStyle listStyle = TextStyle(fontSize: 16);
const TextStyle bold14 = TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
const TextStyle subListStyle =
    TextStyle(fontSize: 12, fontStyle: FontStyle.italic);
const TextStyle styleWelcome =
    TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w500);
const TextStyle msgDialog = TextStyle(fontSize: 14, height: 1.5);

OutlineInputBorder outlineBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
    borderSide: BorderSide(color: Colors.transparent));
