import 'package:flutter/material.dart';

String host = 'car-api2.p.rapidapi.com';
String r_key = '4c06692fecmsh0f5d36a37053312p186a96jsnffe22c37678c';
String r_host = 'car-api2.p.rapidapi.com';

TextStyle txt15 = TextStyle(fontSize: 15);
TextStyle txt20 = TextStyle(fontSize: 20);
TextStyle txt30 = TextStyle(fontSize: 30);

// class AppThemes {
//   static final lightTheme = ThemeData(
//     brightness: Brightness.light,
//     primarySwatch: Colors.blue,
//   );

//   static final darkTheme = ThemeData(
//     brightness: Brightness.dark,
//     primarySwatch: Colors.blueGrey,
//   );
// }

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.black,
  scaffoldBackgroundColor: Colors.white,
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue,
  ),
  appBarTheme: AppBarTheme(
    color: Colors.blue,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue, // Цвет фона для светлой темы
      foregroundColor: Colors.white, // Цвет текста
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Закруглённые углы
      ),
    ),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
    bodySmall: TextStyle(color: Colors.black),
    displayLarge: TextStyle(color: Colors.black),
    displayMedium: TextStyle(color: Colors.black),
    displaySmall: TextStyle(color: Colors.black),
    headlineLarge: TextStyle(color: Colors.black),
    headlineMedium: TextStyle(color: Colors.black),
    headlineSmall: TextStyle(color: Colors.black),
    titleLarge: TextStyle(color: Colors.black),
    titleMedium: TextStyle(color: Colors.black),
    titleSmall: TextStyle(color: Colors.black),
    labelLarge: TextStyle(color: Colors.black),
    labelMedium: TextStyle(color: Colors.black),
    labelSmall: TextStyle(color: Colors.black),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.white,
  scaffoldBackgroundColor: Colors.grey[800],
  appBarTheme: AppBarTheme(
    color: Colors.indigo,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black, // Цвет фона для тёмной темы
      foregroundColor: Colors.white, // Цвет текста
      side: BorderSide(color: Colors.white), // Белая рамка
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Закруглённые углы
      ),
    ),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
    bodySmall: TextStyle(color: Colors.white),
    displayLarge: TextStyle(color: Colors.white),
    displayMedium: TextStyle(color: Colors.white),
    displaySmall: TextStyle(color: Colors.white),
    headlineLarge: TextStyle(color: Colors.white),
    headlineMedium: TextStyle(color: Colors.white),
    headlineSmall: TextStyle(color: Colors.white),
    titleLarge: TextStyle(color: Colors.white),
    titleMedium: TextStyle(color: Colors.white),
    titleSmall: TextStyle(color: Colors.white),
    // labelLarge: TextStyle(color: Colors.white),
    // labelMedium: TextStyle(color: Colors.white),
    // labelSmall: TextStyle(color: Colors.white),
  ),
);
