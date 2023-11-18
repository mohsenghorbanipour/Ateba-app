// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:ateba_app/ateba_app.dart';
import 'package:ateba_app/core/constants/constants.dart';
import 'package:ateba_app/core/network/dio_connectivity_request_retrier.dart';
import 'package:ateba_app/core/network/retry_on_connection_change_inceptor.dart';
import 'package:ateba_app/core/router/ateba_router.dart';
import 'package:ateba_app/core/router/routes.dart';
import 'package:ateba_app/core/utils/app_directory.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/auth/bloc/auth_bloc.dart';
import 'package:ateba_app/modules/bookmarks/bloc/bookmarks_bloc.dart';
import 'package:ateba_app/modules/cart/bloc/cart_bloc.dart';
import 'package:ateba_app/modules/categories/bloc/categories_bloc.dart';
import 'package:ateba_app/modules/home/bloc/home_bloc.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class NetworkHelper {
  factory NetworkHelper() => _instance;

  NetworkHelper._init() {
    initDio();
  }
  Dio dio = Dio(
    BaseOptions(
      baseUrl: Constants.baseUrl,
      validateStatus: (status) => status! < 500,
      headers: {
        'Accept': 'application/json',
      },
    ),
  );
  late bool isLogin;
  String? accessToken;

  Future<void>? isWorking;

  final bool onResponseLog = true;
  final bool onRequestLog = true;
  final bool onErrorLog = true;
  static const Duration postTimeOut = Duration(seconds: 15);

  // final Connectivity connectivity = Connectivity();
  static final NetworkHelper _instance = NetworkHelper._init();

  Future<void> initDio() async {
    AuthBloc authBloc = AuthBloc();
    LoggerHelper.logger.i({'access': authBloc.token});
    isLogin = authBloc.isLogin;
    accessToken = authBloc.token;
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    dio
      ..interceptors.clear()
      ..interceptors.add(InterceptorsWrapper(
          onRequest: onRequest, onResponse: onResponse, onError: onError))
      ..interceptors.add(RetryOnConnectionChangeInterceptor(
          requestRetrier: DioConnectivityRequestRetrier(dio: dio)));
    if (!kIsWeb) {
      dio.interceptors.add(
        CookieManager(
          PersistCookieJar(
            storage: FileStorage((await appDirectory()).path),
          ),
        ),
      );
    }
  }

  // void addCookie() async {
  //   dio.interceptors.add(
  //     CookieManager(
  //       PersistCookieJar(dir: (await appDirectory()).path),
  //     ),
  //   );
  // }

  void onRequest(RequestOptions request,
      RequestInterceptorHandler requestInterceptorHandler) {
    if (onRequestLog) {
      LoggerHelper.logger.i(
        {
          'request': {
            'method': request.method,
            'path': request.path,
            if (request.contentType != 'multipart/form-data')
              'data': request.data,
            'queryParameters': request.queryParameters,
            'headers': request.headers,
            'uri': request.uri.toString()
            // 'extra': request.extra,
          }
        },
      );
    }
    requestInterceptorHandler.next(request);
  }

  Future<void> onResponse(Response<dynamic> response,
      ResponseInterceptorHandler responseInterceptorHandler) async {
    if (onResponseLog) {
      LoggerHelper.logger.i(
        {
          'response': {
            'method': response.requestOptions.method,
            'path': response.requestOptions.path,
            'data': response.data,
            'statusCode': response.statusCode
          }
        },
      );
    }
    if (isLogin && (response.statusCode ?? 0) == 401) {
      // LoggerHelper.logger.i('401');
      if (isWorking != null) {
        await isWorking;
        responseInterceptorHandler
            .resolve(await retry(dio, response.requestOptions));
      }
      // //!LOCK
      var completer = Completer<void>();
      isWorking = completer.future;
      BuildContext context = AtebaRouter.navigatorKey.currentContext!;
      Provider.of<AuthBloc>(context, listen: false).logout();
      Provider.of<HomeBloc>(context, listen: false).clearData();
      Provider.of<CategoriesBloc>(context, listen: false).clearData();
      Provider.of<BookmarksBloc>(context, listen: false).clearData();
      Provider.of<CartBloc>(context, listen: false).clearData();
      context.goNamed(
        Routes.login,
      );
      await initDio();
      // // dio.lock();
      // //!TASK
      // // await AuthBloc().refreshToken();
      // //!UNLOCK
      completer.complete();
      isWorking = null;
      // dio.unlock();
      // LoggerHelper.logger.wtf('retry');
      responseInterceptorHandler
          .resolve(await retry(dio, response.requestOptions));
    }
    return responseInterceptorHandler.next(response);
  }

  void onError(
      DioException dioError, ErrorInterceptorHandler errorInterceptorHandler) {
    if (onErrorLog) {
      LoggerHelper.errorLog(
        {
          'type': dioError.type.toString(),
          'error': dioError.error?.toString(),
          'message': dioError.message,
          'request': {
            'method': dioError.requestOptions.method,
            'path': dioError.requestOptions.path,
            'uri': dioError.requestOptions.uri.toString(),
            if (dioError.requestOptions.contentType != 'multipart/form-data')
              'data': dioError.requestOptions.data,
            'extra': dioError.requestOptions.extra,
            'headers': dioError.requestOptions.headers,
            'queryParameters': dioError.requestOptions.queryParameters,
          },
          'response': {
            'statusCode': dioError.response?.statusCode,
            'statusMessage': dioError.response?.statusMessage,
            'data': dioError.response?.data,
            'extra': dioError.response?.extra,
            'headers': dioError.response?.headers,
          },
        },
        StackTrace.empty,
      );
    }
    errorInterceptorHandler.next(dioError);
  }

  static Future<Response<dynamic>> retry(
      Dio dio, RequestOptions requestOptions) async {
    final Options options = Options(
      method: requestOptions.method,
      headers: dio.options.headers,
    );
    return dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
