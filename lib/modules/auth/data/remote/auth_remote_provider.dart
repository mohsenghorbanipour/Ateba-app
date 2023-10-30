import 'package:ateba_app/core/constants/remote_routes.dart';
import 'package:ateba_app/core/network/network_helper.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:dio/dio.dart';

class AuthRemoteProvider {
  static final NetworkHelper _networkHelper = NetworkHelper();

  static Future<String?> getUserSubscription() async {
    try {
      Response response = await _networkHelper.dio.get(
        RemoteRoutes.getUserSubscription,
      );
      if(response.statusCode == 200) {
        return response.data['expires_at'];
      }
      return null;
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      return null;
    }
  }
}
