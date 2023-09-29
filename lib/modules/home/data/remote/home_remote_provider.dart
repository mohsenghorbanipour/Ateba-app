import 'package:ateba_app/core/constants/remote_routes.dart';
import 'package:ateba_app/core/network/network_helper.dart';
import 'package:ateba_app/core/network/pagination_response_model.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/home/data/models/tutorial.dart';
import 'package:dio/dio.dart';

class HomeRemoteProvider {
  static final NetworkHelper _networkHelper = NetworkHelper();

  static Future<PaginationResponseModel<List<Tutorial>>?> getToturials() async {
    try {
      Response response = await _networkHelper.dio.get(
        RemoteRoutes.getToturials,
      );
      if (response.statusCode == 200) {
        return PaginationResponseModel.fromJson(
          response.data,
          (json) => (json as List<dynamic>)
              .map<Tutorial>(
                  (i) => Tutorial.fromJson(i as Map<String, dynamic>))
              .toList(),
        );
      }
      return null;
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      return null;
    }
  }

  static Future<void> getCourses() async {
    try {
      await _networkHelper.dio.get(
        RemoteRoutes.getCourses,
      );
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }
}
