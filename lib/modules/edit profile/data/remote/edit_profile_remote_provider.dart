import 'package:ateba_app/core/constants/remote_routes.dart';
import 'package:ateba_app/core/network/api_response_model.dart';
import 'package:ateba_app/core/network/network_helper.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/auth/data/models/user.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

class EditProfileRemoteProvider {
  static final NetworkHelper _networkHelper = NetworkHelper();

  static Future<void> updataProfile(User user) async {
    try {
      Response response = await _networkHelper.dio.post(
        RemoteRoutes.getProfile,
        data: user.toJson(),
      );
      if (response.statusCode == 200) {}
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  static Future<ApiResponseModel<String?>> uploadImage(
      FormData formData) async {
    try {
      Response response = await _networkHelper.dio.post(
        RemoteRoutes.uploadImage,
        data: formData,
      );
      if (response.statusCode == 200) {
        return ApiResponseModel(
          success: true,
          message: response.data['message'],
          data: response.data['data']['path'],
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
}
