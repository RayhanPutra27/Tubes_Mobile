import 'package:flutter/material.dart';

ThemeData _customTheme() {
  return ThemeData(
    accentColor: Color(0xFF442B2D),
    primaryColor: Color(0xFF006EF5),
    buttonColor: Color(0xFFFEDBD0),
    scaffoldBackgroundColor: Colors.white,
    cardColor: Color(0xFFF5A718),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: Color(0xFFFEDBD0),
    ),
    errorColor: Colors.red,
    buttonTheme: ThemeData.light().buttonTheme.copyWith(
      buttonColor: Color(0xFFFEDBD0),
      colorScheme: ThemeData.light().colorScheme.copyWith(
        secondary: Color(0xFF442B2D),
      ),
    ),
    buttonBarTheme: ThemeData.light().buttonBarTheme.copyWith(
      buttonTextTheme: ButtonTextTheme.accent,
    ),
    primaryIconTheme: ThemeData.light().primaryIconTheme.copyWith(
      color: Color(0xFF442B2D),
    ),
  );
}