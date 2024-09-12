import 'package:flutter/material.dart';

class AppColors {
  /// App primary color
  static const Color primary =
      Color(0xFFF86E53); // Updated primary gradient start
  static const Color tertiary =
      Color(0xFF7B61FF); // Updated primary gradient start

  /// App secondary color
  static const Color secondary = Color(0xFF64748B); // Updated background color
  /// App nav color
  static const Color nav = Color(0xFF0D0D0D);

  /// App navIcon color
  static const Color navIcon = Color(0xFF191919);

  static const Color unselected = Color(0xFF64748B);

  /// App error color
  static const Color error = Color(0xFFFF003C);

  /// App background color
  static const Color background =
      Color(0xFF000000); // Background same as secondary

  /// App Shadow color
  static const Color shadow = Color.fromRGBO(25, 25, 25, 0.5);

  /// App surface color
  static const Color surface = Color(0xFFFFFFFF); // Surface as white

  /// App disable color
  static const Color disable =
      Color(0xFF64748B); // Updated subtitle color used for disabled

  /// App tertiary color
  // static const Color tertiary = Color(0xFFFA7D61); // Updated logout button color

  ///text field background color
  static const Color inActiveField =
      Color(0xFF18212E); // Updated logout button color

  /// App hint color
  static const Color hint =
      Color(0x99FFFFFF); // Hint color slightly transparent white

  /// Extra card color
  static const Color card = Color(0xFF171717);

  static const LinearGradient gradient = LinearGradient(
    colors: [
      Color(0xFFFF61DA), // Gradient start color updated
      Color(0xFFFFCA61), // Gradient end color updated
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [
      Color(0xFF7B61FF), // 2nd Gradient start color
      Color(0xFFFF61DA), // 2nd Gradient end color
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static MaterialColor primarySwatch = getColorFromHex(primary.value);

  static MaterialColor getColorFromHex(int hexValue) {
    Map<int, Color> colorMap = {
      50: Color(hexValue),
      100: Color(hexValue),
      200: Color(hexValue),
      300: Color(hexValue),
      400: Color(hexValue),
      500: Color(hexValue),
      600: Color(hexValue),
      700: Color(hexValue),
      800: Color(hexValue),
      900: Color(hexValue),
    };
    return MaterialColor(hexValue, colorMap);
  }
}
