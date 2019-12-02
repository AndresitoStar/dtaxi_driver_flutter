import 'package:flutter/material.dart';

var kPrimaryColor = Color.fromRGBO(247, 147, 30, 1);

var dtaxiThemeData = new ThemeData(
  primaryColor: kPrimaryColor,
  accentColor: kPrimaryColor.withOpacity(0.75),
  tabBarTheme: TabBarTheme(labelColor: Colors.white),
  appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.white)),
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
  scaffoldBackgroundColor: Color.fromRGBO(255, 255, 255, 1),
  buttonTheme: ButtonThemeData(
    buttonColor: kPrimaryColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
  ),
  cursorColor: kPrimaryColor,
  inputDecorationTheme: InputDecorationTheme(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: kPrimaryColor, width: 2),
      ),
      labelStyle: TextStyle(color: Colors.white),
      hintStyle: TextStyle(color: kPrimaryColor),
      focusColor: kPrimaryColor),
  buttonColor: kPrimaryColor,
  dividerColor: Colors.grey.shade200,
);

var dtaxiThemeDataDark = new ThemeData(
  primaryColor: kPrimaryColor,
  accentColor: Colors.white,
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
  scaffoldBackgroundColor: Color.fromRGBO(255, 255, 255, 1),
  buttonTheme: ButtonThemeData(
    buttonColor: kPrimaryColor,
    textTheme: ButtonTextTheme.accent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
  ),
  primaryIconTheme: IconThemeData(
    color: Colors.white,
  ),
  cursorColor: kPrimaryColor,
  inputDecorationTheme: InputDecorationTheme(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: kPrimaryColor, width: 2),
      ),
      labelStyle: TextStyle(color: Colors.white),
      hintStyle: TextStyle(color: kPrimaryColor),
      focusColor: kPrimaryColor),
  buttonColor: kPrimaryColor,
  dividerColor: Colors.grey.shade200,
);
