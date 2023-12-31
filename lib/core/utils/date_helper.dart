import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/core/utils/text_input_formatters.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shamsi_date/shamsi_date.dart';

class DateHelper {
  static String getShamsiData(String date, {bool withDay = false}) {
    try {
      int year = int.parse(date.substring(0, date.indexOf('-')));
      int month = int.parse(
          date.substring((date.indexOf('-')) + 1, date.lastIndexOf('-')));
      int day = int.parse(date.substring(
          (date.lastIndexOf('-') + 1), (date.lastIndexOf('-') + 3)));
      Jalali jalali = Jalali.fromGregorian(
        Gregorian(year, month, day),
      );
      return withDay
          ? '${jalali.formatter.dd} - ${jalali.formatter.mN} - ${jalali.formatter.yyyy}'
          : '${jalali.formatter.mN} - ${jalali.formatter.yyyy}';
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      return '';
    }
  }

  static String getDistanceWithToday(String date) {
    int year = int.parse(date.substring(0, date.indexOf('-')));
    int month = int.parse(
        date.substring((date.indexOf('-')) + 1, date.lastIndexOf('-')));
    int day = int.parse(date.substring(
        (date.lastIndexOf('-') + 1), (date.lastIndexOf('-') + 3)));
    Jalali jalali = Jalali.fromGregorian(
      Gregorian(year, month, day),
    );
    int distance = jalali.distanceFrom(Jalali.now()) * -1;
    if (distance == 0) {
      return 'today'.tr();
    } else if (distance == 1) {
      return 'yesterday'.tr();
    } else {
      if (distance >= 365) {
        return TextInputFormatters.toPersianNumber(
                (distance ~/ 365).toString()) +
            'year_ago'.tr();
      } else if (distance >= 30) {
        return TextInputFormatters.toPersianNumber(
                (distance ~/ 30).toString()) +
            'month_ago'.tr();
      } else {
        return TextInputFormatters.toPersianNumber(
            '$distance ${'day_ago'.tr()}');
      }
    }
  }

  static String getRealDate(String date) {
    int year = int.parse(date.substring(0, date.indexOf('-')));
    int month = int.parse(
        date.substring((date.indexOf('-')) + 1, date.lastIndexOf('-')));
    int day = int.parse(date.substring(
        (date.lastIndexOf('-') + 1), (date.lastIndexOf('-') + 3)));
    Jalali jalali = Jalali.fromGregorian(
      Gregorian(year, month, day),
    );
    int distance = jalali.distanceFrom(Jalali.now()) * -1;
    if (distance == 0) {
      int? index = date.indexOf('T');
      if (index != -1) {
        String hour = date.substring(index + 1, index + 3);
        String min = date.substring(index + 4, index + 6);
        String sec = date.substring(index + 7, index + 9);
        DateTime tempDate = DateTime(
            year, month, day, int.parse(hour), int.parse(min), int.parse(sec));
        if (DateTime.now().difference(tempDate).inHours != 0) {
          return '${TextInputFormatters.toPersianNumber(DateTime.now().difference(tempDate).inHours.toString())}  ${'hour_ago'.tr()}';
        } else {
          if (DateTime.now().difference(tempDate).inMinutes > 0) {
            return '${TextInputFormatters.toPersianNumber(DateTime.now().difference(tempDate).inMinutes.toString())}  ${'min_ago'.tr()}';
          } else if (DateTime.now().difference(tempDate).inMinutes < 0) {
            return '${TextInputFormatters.toPersianNumber((DateTime.now().difference(tempDate).inMinutes + 60).toString())}  ${'min_ago'.tr()}';
          } else {
            return 'moment_ago'.tr();
          }
        }
      }
      return '';
    } else if (distance == 1) {
      return 'yesterday'.tr();
    } else {
      if (distance >= 365) {
        return TextInputFormatters.toPersianNumber(
                (distance ~/ 365).toString()) +
            'year_ago'.tr();
      } else if (distance >= 30) {
        return TextInputFormatters.toPersianNumber(
                (distance ~/ 30).toString()) +
            'month_ago'.tr();
      } else {
        return TextInputFormatters.toPersianNumber(
            '$distance ${'day_ago'.tr()}');
      }
    }
  }

  static String getRealTimeVideo(int beginningSecond) {
    if (beginningSecond == 0) {
      return TextInputFormatters.toPersianNumber('00:00:00');
    } else {
      int hour = (beginningSecond ~/ 60) ~/ 60;
      int min = beginningSecond ~/ 60;
      if (min >= 60) {
        min = min % 60;
      }
      int sec = beginningSecond % 60;
      String secount = sec < 10 ? '0$sec' : '$sec';
      String minute = min < 10 ? '0$min' : '$min';
      String hours = hour < 10 ? '0$hour' : '$hour';
      return TextInputFormatters.toPersianNumber('$hours:$minute:$secount');
    }
  }
}
