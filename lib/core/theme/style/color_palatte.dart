import 'package:flutter/material.dart';

class ColorPalette {
  const ColorPalette({
    required this.primary,
    required this.scaffoldBackground,
    required this.background,
    required this.textPrimary,
    required this.border,
    // required this.primaryDark,
    // required this.primaryLight,
    // required this.scaffoldBackground,
    // required this.background,
    // required this.divider,
    // required this.textPrimary,
    // required this.textSecondary,
    // required this.textThird,
    // required this.disabled,
    // required this.error,
    // required this.success,
    // required this.info,
    // required this.splash,
    // required this.shadow,
    // this.white = Colors.white,
    // this.black = Colors.black,
    // this.blue = const Color(0xff1DA1F2),
    // this.darkGray = const Color(0xff657786),
    // this.lightGray = const Color(0xffAAB8C2),
    // this.extraLightGray = const Color(0xffE1E8ED),
    // this.fieldColor = const Color(0xffE6ECF0),
    // this.splashGradientTop = const Color(0xff649AFF),
    // this.splashGradientBottom = const Color(0xff377DFF),
    // this.splashLogo = const Color(0xffffffff),
    // this.purple = const Color(0xffB183F8),
  });

  final Color primary;
  final Color scaffoldBackground;
  final Color background;
  final Color textPrimary;
  final Color border;
  final Color grey = const Color(0xffF5F5F5);
  final Color silver = const Color(0xffE0E0E0);
  final Color error = const Color(0xffE7241C);
  final Color darkWhite = const Color(0xffF5F3F3);
  final Color midGrey = const Color(0xffE7ECEF);

  static ColorPalette light = const ColorPalette(
      primary: Color(0xff12B2B2),
      scaffoldBackground: Color(0xffF5F6F7),
      background: Colors.white,
      textPrimary: Color(0xff242423),
      border: Color.fromRGBO(36, 36, 35, 0.1));

  static ColorPalette dark = const ColorPalette(
      primary: Color(0xff12B2B2),
      scaffoldBackground: Color(0xff121212),
      background: Color(0xff363636),
      textPrimary: Color(0xffE3E3E3),
      border: Color.fromRGBO(36, 36, 35, 0.1));

  factory ColorPalette.of(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.light) {
      return light;
    } else {
      return dark;
    }
  }

  factory ColorPalette.fromBrightness(Brightness brightness) =>
      brightness == Brightness.light ? light : dark;
}
