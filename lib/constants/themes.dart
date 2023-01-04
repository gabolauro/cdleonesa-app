import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainTheme {
  static const Color mainColor = Color(0xFFD00713);
  static const Color mainColorLight = Color.fromARGB(255, 254, 90, 101);
  static const Color mainColorDark = Color(0xFF910E1E);
  static const Color softGrey = Color(0xFFF5F5F5);
  static const Color darkGrey = Color.fromARGB(255, 95, 95, 95);

  // Main Theme
  static Map<int, Color> _colors = {
    50: mainColor,
    100: mainColor,
    200: mainColor,
    300: mainColor,
    400: mainColor,
    500: mainColor,
    600: mainColor,
    700: mainColor,
  };

  static MaterialColor _colorCustom = MaterialColor(mainColor.value, _colors);

  static ThemeData theme() {
    return ThemeData(
        primarySwatch: _colorCustom,
        primaryColor: mainColor,
        primaryColorDark: mainColor,
        // primaryColorLight: Color(mainColorLight),
        scaffoldBackgroundColor: mainColor,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: softGrey,
          systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.white,
            statusBarColor: softGrey,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
          )
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent
        ),
        fontFamily: 'Roboto',
        iconTheme: const IconThemeData(color: Color(0xff434300)),
        );
  }


}