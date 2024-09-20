import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primaryColor: const Color(0xff1565C0),
    scaffoldBackgroundColor: const Color(0xffFFFFFF),
    brightness: Brightness.light,
  );

  static final darkTheme = ThemeData(
    primaryColor: const Color(0xff1565C0),
    scaffoldBackgroundColor: const Color(0xff000000),
    brightness: Brightness.dark,
  );
}
