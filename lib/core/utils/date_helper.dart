import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/core/utils/text_input_formatters.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shamsi_date/shamsi_date.dart';

class DateHelper {
  static String getShamsiData(String date) {
    try {
      int year = int.parse(date.substring(0, date.indexOf('-')));
      int month = int.parse(
          date.substring((date.indexOf('-')) + 1, date.lastIndexOf('-')));
      int day = int.parse(date.substring(
          (date.lastIndexOf('-') + 1), (date.lastIndexOf('-') + 3)));
      Jalali jalali = Jalali.fromGregorian(
        Gregorian(year, month, day),
      );
      return '${jalali.formatter.mN} - ${jalali.formatter.yyyy}';
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
      return TextInputFormatters.toPersianNumber('$distance ${'day_ago'.tr()}');
    }
  }
}
