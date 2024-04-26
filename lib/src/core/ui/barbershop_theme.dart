import 'package:flutter/material.dart';

sealed class ColorsTheme {
  static const grey = Color(0xFF999999);
  static const brown = Color(0xFFB07B01);
  static const greyLight = Color(0xFFE6E2E9);
  static const red = Color(0xFFEB1212);
}

sealed class FontFamily {
  static const poppins = 'Poppins';
}

sealed class BarbershopTheme {
  static final _defaultInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(
      color: ColorsTheme.grey,
    ),
  );

  static ThemeData themeData = ThemeData(
    // #region Input Decoration

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      labelStyle: const TextStyle(
        color: ColorsTheme.grey,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      hintStyle: const TextStyle(
        color: ColorsTheme.grey,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      border: _defaultInputBorder,
      enabledBorder: _defaultInputBorder,
      focusedBorder: _defaultInputBorder,
      errorBorder: _defaultInputBorder.copyWith(
        borderSide: const BorderSide(color: ColorsTheme.red),
      ),
    ),
    // #endregion

    // #region Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsTheme.brown,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(
          fontFamily: FontFamily.poppins,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: ColorsTheme.brown,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(
          fontFamily: FontFamily.poppins,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    // #endregion
  );

  // #region Typography

  static const largeTitleStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w600,
    fontSize: 36,
  );

  static const mediumTitleStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );

  static const smallTitleStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );

  static const mediumBodyStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );

  static const boldBodyStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w700,
    fontSize: 14,
  );

  static const smallMdBodyStyle = TextStyle(
    color: Colors.brown,
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );

  static const smallRegBodyStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );

  // #endregion
}
