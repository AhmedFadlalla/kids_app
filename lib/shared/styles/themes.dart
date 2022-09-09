
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'colors.dart';

ThemeData lightTheme = ThemeData(
    primarySwatch: defaultColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        titleSpacing: 20.0,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.red,
          statusBarIconBrightness: Brightness.dark,
        ),
        titleTextStyle: TextStyle(
          fontFamily: 'Jannah',
            color: Colors.black, fontSize: 40.0, fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(color: Colors.black)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: defaultColor,
        unselectedItemColor: Colors.grey,
        elevation: 20.0,
        backgroundColor:  Color(0xFF252c4a)),

    textTheme: const TextTheme(
        bodyText1: TextStyle(
            fontSize: 50.0, fontWeight: FontWeight.w600, color: Colors.black),
    subtitle1: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
        height: 1.3

    ),

    ),
    fontFamily: 'Jannah');
ThemeData darkTheme = ThemeData(
    primarySwatch: defaultColor,


    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        elevation: 20.0,),

    textTheme: const TextTheme(
        bodyText1: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white),
        subtitle1: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            height: 1.3
        )
    ),
    fontFamily: 'Jannah');
