import 'package:ateba_app/core/constants/remote_routes.dart';
import 'package:ateba_app/core/network/network_helper.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/auth/data/models/user.dart';
import 'package:dio/dio.dart';

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

  static Future<void> uploadImage(FormData formData) async {
    try {
      Response response = await _networkHelper.dio.post(
        RemoteRoutes.uploadImage,
        data: formData, 
      );
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }
}
