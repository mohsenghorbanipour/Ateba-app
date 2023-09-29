import 'package:ateba_app/core/constants/remote_routes.dart';
import 'package:ateba_app/core/network/network_helper.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:dio/dio.dart';

class CategoriesRemoteProvider {
  static final NetworkHelper _networkHelper = NetworkHelper();

  static Future<void> getCategories() async {
    try {
      Response response = await _networkHelper.dio.get(
        RemoteRoutes.getCategories,
      );
      if (response.statusCode == 200) {}
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  // static Future<void> getCategoryDetials(String slug) async {
  //   try {
  //     Response response = await _networkHelper.dio.get(
  //       RemoteRoutes.getCategoryDetails(slug),
  //     );
  //     if (response.statusCode == 200) {}
  //   } catch (e, s) {
  //     LoggerHelper.errorLog(e, s);
  //   }
  // }

  // static Future<PaginationResponseModel<List<Package>>?> getPackages() async {
  //   try {
  //     Response response = await _networkHelper.dio.get(
  //       RemoteRoutes.getPackages,
  //     );
  //     if (response.statusCode == 200) {
  //       return PaginationResponseModel.fromJson(
  //         response.data,
  //         (json) => (json as List<dynamic>)
  //             .map<Package>((i) => Package.fromJson(i as Map<String, dynamic>))
  //             .toList(),
  //       );
  //     }
  //     return null;
  //   } catch (e, s) {
  //     LoggerHelper.errorLog(e, s);
  //     return null;
  //   }
  // }
}
