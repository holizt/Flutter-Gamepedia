import 'package:flutter/material.dart';

class ThemeFont {
  const ThemeFont();

  static const String fontName = 'WorkSans';

  static const TextTheme textTheme = TextTheme(
    headline5: headline,
    headline6: title,
    subtitle2: subtitle,
    bodyText1: body1,
    bodyText2: body2,
    caption: caption,
  );

  static const TextStyle headline = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: Colors.white,
  );

  static const TextStyle title = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: Colors.white,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.10,
    color: Colors.white,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: 0.5,
    color: Colors.white,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: Colors.white,
  );

  static const TextStyle caption = TextStyle(
      fontFamily: fontName,
      fontWeight: FontWeight.w400,
      fontSize: 12,
      letterSpacing: 0.2,
      color: Colors.grey);
}
