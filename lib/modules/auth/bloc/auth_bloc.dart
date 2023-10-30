import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/auth/data/remote/auth_remote_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:shamsi_date/shamsi_date.dart';

class AuthBloc extends ChangeNotifier {
  factory AuthBloc() => _instance;
  AuthBloc._init();
  static final AuthBloc _instance = AuthBloc._init();

  Jalali? subscriptionExpireDate;

  Future<void> getUserSubscription() async {
    try {
      String? expireData = await AuthRemoteProvider.getUserSubscription();
      if (expireData?.isNotEmpty ?? false) {
        int year = int.parse(expireData!.substring(0, expireData.indexOf('-')));
        int month = int.parse(expireData.substring(
            (expireData.indexOf('-')) + 1, expireData.lastIndexOf('-')));
        int day = int.parse(expireData.substring(
            (expireData.lastIndexOf('-') + 1),
            (expireData.lastIndexOf('-') + 3)));
        subscriptionExpireDate = Jalali.fromGregorian(
          Gregorian(
            year,
            month,
            day,
          ),
        );
      }
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }
}
