import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputFormatters {
  static TextInputFormatter persianNumberFormatter(BuildContext context) =>
      TextInputFormatter.withFunction((oldValue, newValue) {
        String text = newValue.text;
        if (context.locale.toString() == 'fa_IR') {
          text = text
              .replaceAll(
                  '0'
                      ''
                      '',
                  '۰')
              .replaceAll('1', '۱')
              .replaceAll('2', '۲')
              .replaceAll('3', '۳')
              .replaceAll('4', '۴')
              .replaceAll('5', '۵')
              .replaceAll('6', '۶')
              .replaceAll('7', '۷')
              .replaceAll('8', '۸')
              .replaceAll('9', '۹');
          return newValue.copyWith(text: text);
        } else {
          return newValue.copyWith(text: text);
        }
      });

  static String toPersianNumber(String number) {
    String text;
    text = number
        .replaceAll('0', '۰')
        .replaceAll('1', '۱')
        .replaceAll('2', '۲')
        .replaceAll('3', '۳')
        .replaceAll('4', '۴')
        .replaceAll('5', '۵')
        .replaceAll('6', '۶')
        .replaceAll('7', '۷')
        .replaceAll('8', '۸')
        .replaceAll('9', '۹');
    return text;
  }

  static String toEnglishNumber(String number) {
    String text = number
        .replaceAll('۰', '0')
        .replaceAll('۱', '1')
        .replaceAll('۲', '2')
        .replaceAll('۳', '3')
        .replaceAll('۴', '4')
        .replaceAll('۵', '5')
        .replaceAll('۶', '6')
        .replaceAll('۷', '7')
        .replaceAll('۸', '8')
        .replaceAll('۹', '9');
    return text;
  }
}
