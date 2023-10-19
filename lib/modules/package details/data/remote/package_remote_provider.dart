import 'package:ateba_app/core/constants/remote_routes.dart';
import 'package:ateba_app/core/network/api_response_model.dart';
import 'package:ateba_app/core/network/network_helper.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/package%20details/data/models/package_details.dart';
import 'package:dio/dio.dart';

class PackageRemoteProvider {
  static final NetworkHelper _networkHelper = NetworkHelper();

  static Future<ApiResponseModel<PackageDetails>?> getPackageDetials(
      String slug) async {
    try {
      Response response = await _networkHelper.dio.get(
        RemoteRoutes.getPackageDetials(
          slug,
        ),
      );
      if (response.statusCode == 200) {
        return ApiResponseModel.fromJson(
          response.data,
          (json) => PackageDetails.fromJson(
            json,
          ),
        );
      }
      return null;
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      return null;
    }
  }
}
