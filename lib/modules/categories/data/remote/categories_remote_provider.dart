import 'package:ateba_app/core/constants/remote_routes.dart';
import 'package:ateba_app/core/network/api_response_model.dart';
import 'package:ateba_app/core/network/network_helper.dart';
import 'package:ateba_app/core/network/pagination_response_model.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/categories/data/models/category.dart';
import 'package:ateba_app/modules/home/data/models/course.dart';
import 'package:ateba_app/modules/home/data/models/package.dart';
import 'package:ateba_app/modules/home/data/models/tutorial.dart';
import 'package:dio/dio.dart';

class CategoriesRemoteProvider {
  static final NetworkHelper _networkHelper = NetworkHelper();

  static Future<ApiResponseModel<List<Category>>?> getCategories() async {
    try {
      Response response = await _networkHelper.dio.get(
        RemoteRoutes.getCategories,
      );
      if (response.statusCode == 200) {
        return ApiResponseModel.fromJson(
          response.data,
          (json) => (json as List<dynamic>)
              .map(
                (e) => Category.fromJson(e),
              )
              .toList(),
        );
      }
      return null;
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      return null;
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

  static Future<PaginationResponseModel<List<Course>>?> getCourses(
      {int page = 1}) async {
    try {
      Response response = await _networkHelper.dio.get(
        RemoteRoutes.getCourses,
        queryParameters: {
          'page': page,
        },
      );
      if (response.statusCode == 200) {
        return PaginationResponseModel.fromJson(
          response.data,
          (json) => (json as List<dynamic>)
              .map<Course>((i) => Course.fromJson(i as Map<String, dynamic>))
              .toList(),
        );
      }
      return null;
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      return null;
    }
  }

  static Future<PaginationResponseModel<List<Package>>?> getPackages(
      {int page = 1}) async {
    try {
      Response response = await _networkHelper.dio
          .get(RemoteRoutes.getPackages, queryParameters: {
        'page': page,
      });
      if (response.statusCode == 200) {
        return PaginationResponseModel.fromJson(
          response.data,
          (json) => (json as List<dynamic>)
              .map(
                (e) => Package.fromJson(e),
              )
              .toList(),
        );
      }
      return null;
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      return null;
    }
  }
}
