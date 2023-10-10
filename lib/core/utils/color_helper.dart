import 'package:flutter/material.dart';

class ColorHelper {
  static Color getColorFromHexCode(String hexCode) {
    String code = hexCode.startsWith('#') ? hexCode.substring(1) : hexCode;
    return Color(int.parse('0xff$code'));
  }
}
