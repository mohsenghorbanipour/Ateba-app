import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class DioConnectivityRequestRetrier {
  const DioConnectivityRequestRetrier({
    required this.dio,
  });

  final Dio dio;

  Future<Response<dynamic>> scheduleRequestRetry(
      RequestOptions requestOptions) async {
    late StreamSubscription streamSubscription;
    final responseCompleter = Completer<Response<dynamic>>();

    streamSubscription = Connectivity().onConnectivityChanged.listen(
      (result) {
        if (result == ConnectivityResult.wifi ||
            result == ConnectivityResult.mobile) {
          streamSubscription.cancel();
          responseCompleter.complete(
            dio.request(
              requestOptions.path,
              cancelToken: requestOptions.cancelToken,
              data: requestOptions.data,
              onReceiveProgress: requestOptions.onReceiveProgress,
              onSendProgress: requestOptions.onSendProgress,
              queryParameters: requestOptions.queryParameters,
              options: Options(
                contentType: requestOptions.contentType,
                extra: requestOptions.extra,
                followRedirects: requestOptions.followRedirects,
                headers: requestOptions.headers,
                listFormat: requestOptions.listFormat,
                maxRedirects: requestOptions.maxRedirects,
                method: requestOptions.method,
                receiveDataWhenStatusError:
                    requestOptions.receiveDataWhenStatusError,
                receiveTimeout: requestOptions.receiveTimeout,
                requestEncoder: requestOptions.requestEncoder,
                responseDecoder: requestOptions.responseDecoder,
                responseType: requestOptions.responseType,
                sendTimeout: requestOptions.sendTimeout,
                validateStatus: requestOptions.validateStatus,
              ),
            ),
          );
        }
      },
    );

    return responseCompleter.future;
  }
}
