import 'package:ateba_app/core/constants/remote_routes.dart';
import 'package:ateba_app/core/network/api_response_model.dart';
import 'package:ateba_app/core/network/network_helper.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/auth/data/models/config_item.dart';
import 'package:ateba_app/modules/auth/data/models/profile_config_response.dart';
import 'package:ateba_app/modules/auth/data/models/token_response.dart';
import 'package:ateba_app/modules/auth/data/models/user.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

class AuthRemoteProvider {
  static final NetworkHelper _networkHelper = NetworkHelper();

  static Future<ApiResponseModel<bool>> sendCode(String phone) async {
    try {
      Response response = await _networkHelper.dio.post(
        RemoteRoutes.sendCode,
        data: FormData.fromMap(
          {
            'phone': phone,
          },
        ),
      );
      if (response.statusCode == 200) {
        return ApiResponseModel(
          success: true,
          data: true,
          message: response.data['message'],
        );
      }
      return ApiResponseModel(
        success: false,
        data: false,
        message: response.data['message'],
      );
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      return ApiResponseModel(
        success: true,
        data: true,
        message: 'sth_wrong'.tr(),
      );
    }
  }

  static Future<ApiResponseModel<TokenResponse?>> verifyCode(
      String phone, String code) async {
    try {
      Response response = await _networkHelper.dio.post(
        RemoteRoutes.verifyCode,
        data: FormData.fromMap(
          {
            'phone': phone,
            'password': code,
          },
        ),
      );
      if (response.statusCode == 200) {
        return ApiResponseModel<TokenResponse?>(
          success: true,
          message: response.data['message'],
          data: TokenResponse.fromJson(
            response.data,
          ),
        );
      }
      return ApiResponseModel<TokenResponse>(
        success: false,
        message: response.data['message'],
        data: null,
      );
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      return ApiResponseModel(
        success: false,
        message: 'sth_wrong'.tr(),
        data: null,
      );
    }
  }

  static Future<ApiResponseModel<User?>> getProfile() async {
    try {
      Response response = await _networkHelper.dio.get(
        RemoteRoutes.getProfile,
      );
      if (response.statusCode == 200) {
        return ApiResponseModel(
          success: true,
          message: response.data['message'],
          data: User.fromJson(
            response.data['data'],
          ),
        );
      }
      return ApiResponseModel(
        success: false,
        message: response.data['message'],
        data: null,
      );
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      return ApiResponseModel(
        success: false,
        message: 'sth_wrong'.tr(),
        data: null,
      );
    }
  }

  static Future<ApiResponseModel<String?>> getUserSubscription() async {
    try {
      Response response = await _networkHelper.dio.get(
        RemoteRoutes.getUserSubscription,
      );
      if (response.statusCode == 200) {
        return ApiResponseModel(
            success: true,
            message: response.data['message'],
            data: response.data['expires_at']);
      }
      return ApiResponseModel(
        success: true,
        message: response.data['message'],
        data: null,
      );
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      return ApiResponseModel(
        success: true,
        message: 'sth_wrong'.tr(),
        data: null,
      );
    }
  }

  // static Future<void> getProfileConfig() async {
  //   try {
  //     Response response = await _networkHelper.dio.get(
  //       RemoteRoutes.getProfileConfig,
  //     );
  //   } catch (e, s) {
  //     LoggerHelper.errorLog(e, s);
  //   }
  // }

  static Future<ApiResponseModel<ProfileConfigResponse>?>
      getProfileConfig() async {
    try {
      Response response = await _networkHelper.dio.get(
        RemoteRoutes.getProfileConfig,
      );
      if (response.statusCode == 200) {
        return ApiResponseModel(
          success: true,
          message: response.data['message'],
          data: ProfileConfigResponse.fromJson(
            response.data,
          ),
        );
      }
      return ApiResponseModel(
        success: false,
        message: response.data['message'],
        data: null,
      );
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      return ApiResponseModel(
        success: false,
        message: 'sth_wrong'.tr(),
        data: null,
      );
    }
  }

  static Future<ApiResponseModel<List<ConfigItem>?>> getCities(
      int provinceId) async {
    try {
      Response response = await _networkHelper.dio.get(
        RemoteRoutes.getCities(provinceId),
      );
      if (response.statusCode == 200) {
        return ApiResponseModel(
          success: true,
          message: response.data is Map<String, dynamic>
              ? response.data['message']
              : '',
          data: (response.data as List<dynamic>)
              .map(
                (e) => ConfigItem.fromJson(e),
              )
              .toList(),
        );
      }
      return ApiResponseModel(
        success: false,
        message: response.data is Map<String, dynamic>
            ? response.data['message']
            : 'sth_wrong'.tr(),
        data: null,
      );
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      return ApiResponseModel(
        success: false,
        message: 'sth_wrong'.tr(),
        data: null,
      );
    }
  }
}
