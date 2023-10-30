import 'package:ateba_app/core/constants/remote_routes.dart';
import 'package:ateba_app/core/network/network_helper.dart';
import 'package:ateba_app/core/network/pagination_response_model.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/categories/data/models/category_details_response.dart';
import 'package:ateba_app/modules/home/data/models/tutorial.dart';
import 'package:dio/dio.dart';

class CategoryDetailsRemoteProvider {
  static final NetworkHelper _networkHelper = NetworkHelper();

  static Future<dynamic> getCategoryDetails(String slug) async {
    try {
      Response response = await _networkHelper.dio.get(
        RemoteRoutes.getCategoryDetails(slug),
      );
      if (response.statusCode == 200) {
        if (response.data['hasSubCategory'] as bool) {
          return PaginationResponseModel.fromJson(
            response.data,
            (json) => (json as List<dynamic>)
                .map(
                  (e) => CategoryDetailsResponse.fromJson(e),
                )
                .toList(),
          );
        } else {
          return PaginationResponseModel.fromJson(
            response.data,
            (json) => (json as List<dynamic>)
                .map(
                  (e) => Tutorial.fromJson(e),
                )
                .toList(),
          );
        }
      }
      return null;
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      return null;
    }
  }
}
