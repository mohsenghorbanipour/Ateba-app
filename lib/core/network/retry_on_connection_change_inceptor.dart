import 'dart:io';

import 'package:ateba_app/core/network/dio_connectivity_request_retrier.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:dio/dio.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  RetryOnConnectionChangeInterceptor({
    required this.requestRetrier,
  });

  final DioConnectivityRequestRetrier requestRetrier;

  @override
  // ignore: avoid_renaming_method_parameters
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      try {
        handler.resolve(
            await requestRetrier.scheduleRequestRetry(err.requestOptions));
      } catch (e) {
        LoggerHelper.logger.e(e);
      }
    }
    handler.next(err);
  }

  bool _shouldRetry(DioException err) =>
      err.error != null && err.error is SocketException;
}
