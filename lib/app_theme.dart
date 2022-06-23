import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static InputDecorationTheme get _inputDecorationTheme {
    return const InputDecorationTheme();
  }

  static ThemeData get lightThemeData {
    return ThemeData(
      fontFamily: 'Ubuntu',
      brightness: Brightness.light,
      inputDecorationTheme: _inputDecorationTheme,
      cardColor: Colors.grey.shade200,
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.black,
        actionsIconTheme: IconThemeData(color: Colors.black),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black,
        ),
      ),
    );
  }

  static ThemeData get darkThemeData {
    return ThemeData(
      fontFamily: 'Ubuntu',
      cardColor: Colors.grey.shade900,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      inputDecorationTheme: _inputDecorationTheme,
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.white,
        actionsIconTheme: IconThemeData(color: Colors.white),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
        ),
      ),
    );
  }
}
