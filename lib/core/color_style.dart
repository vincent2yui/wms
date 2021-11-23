import 'package:flutter/material.dart';

class ColorStyle {
  static const mainBlackColor = Color(0xFF100C0F);
  static const mainWhiteColor = Color(0xFFFFFAFA);
  static const primaryColor = Color(0xFF05389A);
  static const secondaryColor = Color(0xFF95D6FE);
  static const tertiaryColor = Color(0xFF3E83D5);
  static const errorColor = Colors.red;

  static const disableMainColor = Colors.black38;
  static const disableSecondaryColor = Colors.white70;
  static const defaultScaffoldColor = Color(0xFFF1F2F3);

  static final bannerDemoColor = Colors.green.withOpacity(0.6);
  static final bannerDevColor = Colors.orange.withOpacity(0.6);
  static final bannerPrdColor = Colors.blue.withOpacity(0.6);
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
