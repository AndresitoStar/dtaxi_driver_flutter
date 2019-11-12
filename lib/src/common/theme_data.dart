import 'package:flutter/material.dart';

var dtaxiThemeData = new ThemeData(
  primaryColor: Color.fromRGBO(247, 147, 30, 1),
  accentColor: Color.fromRGBO(38, 169, 224, 1),
  primaryColorDark: Color.fromRGBO(32, 66, 135, 1),
  tabBarTheme: TabBarTheme(labelColor: Colors.white),
  primaryTextTheme: TextTheme(
    title: TextStyle(color: Colors.white),
    button: TextStyle(
      color: Colors.white,
    ),
    body1: TextStyle(
      color: Colors.black,
    ),
  ),
  errorColor: Color.fromRGBO(251, 0, 38, 1),
  scaffoldBackgroundColor: Color.fromRGBO(214, 214, 214, 1),
  buttonTheme: ButtonThemeData(
    buttonColor: Color.fromRGBO(38, 169, 224, 1),
  ),
  primaryIconTheme: IconThemeData(
    color: Colors.white,
  ),
  buttonColor: Color.fromRGBO(38, 169, 224, 1),
  dividerColor: Colors.grey.shade200,
);
