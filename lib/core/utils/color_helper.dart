import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ColorHelper {
  static List<Color> colors = const [
    Color(0XffFFD534),
    Color(0XffFD9644),
    Color(0XffFC5C65),
    Color(0Xff45AAF2),
    Color(0XffBD9ADF),
    Color(0Xff61CBC0),
    Color(0XffD38D67),
    Color(0XffA8A9AA),
    Color(0XffFEA0CC),
    Color(0XffCCD059)
  ];

  static Color getColorFromHexCode(String hexCode) {
    String code = hexCode.startsWith('#') ? hexCode.substring(1) : hexCode;
    return Color(int.parse('0xff$code'));
  }

  static Color getRandomColorForProfileUsers(String name) {
    try {
      List<int> asciiCodes = [];
      for (int i = 0; i < name.length; i++) {
        int asciiCode = name.codeUnitAt(i);
        asciiCodes.add(asciiCode);
      }
      int sum = 0;
      if (asciiCodes.isNotEmpty) {
        sum = asciiCodes.reduce((a, b) => a + b);
      }
      int index = sum % 10;
      return colors[index];
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      return colors[0];
    }
  }
}
