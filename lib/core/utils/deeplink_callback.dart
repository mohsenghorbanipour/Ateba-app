import 'package:ateba_app/core/components/toast_component.dart';
import 'package:ateba_app/core/router/ateba_router.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

Future<void> deepLinkCallBack(Uri? uri) async {
  try {
    BotToast.showLoading();
    await Future.delayed(const Duration(seconds: 2));
    ToastComponent.show(uri.toString());

    Map<String, dynamic> queryParameters = uri?.queryParameters ?? {};
    NavigatorState navigator = AtebaRouter.navigatorKey.currentState!;
    BotToast.cleanAll();
    LoggerHelper.logger.wtf(uri.toString());
  } catch (error, s) {
    LoggerHelper.errorLog(error, s);
  }
}
