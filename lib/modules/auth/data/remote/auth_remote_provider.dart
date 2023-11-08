import 'package:ateba_app/core/constants/remote_routes.dart';
import 'package:ateba_app/core/network/api_response_model.dart';
import 'package:ateba_app/core/network/network_helper.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/auth/data/models/user.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class AuthRemoteProvider {
  static final NetworkHelper _networkHelper = NetworkHelper();

  static Future<ApiResponseModel<User>?> getProfile() async {
    try {
      Response response = await _networkHelper.dio.get(
        RemoteRoutes.getProfile,
      );
      if (response.statusCode == 200) {
        return ApiResponseModel.fromJson(
          response.data,
          (json) => User.fromJson(json),
        );
      }
      return null;
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      return null;
    }
  }

  static Future<String?> getUserSubscription() async {
    try {
      Response response = await _networkHelper.dio.get(
        RemoteRoutes.getUserSubscription,
      );
      if (response.statusCode == 200) {
        return response.data['expires_at'];
      }
      return null;
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      return null;
    }
  }

  
}
