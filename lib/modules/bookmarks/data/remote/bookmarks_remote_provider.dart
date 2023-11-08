import 'package:ateba_app/core/constants/remote_routes.dart';
import 'package:ateba_app/core/network/api_response_model.dart';
import 'package:ateba_app/core/network/network_helper.dart';
import 'package:ateba_app/core/network/pagination_response_model.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/bookmarks/data/models/bookmark.dart';
import 'package:dio/dio.dart';

class BookmarksRemoteProvider {
  static final NetworkHelper _networkHelper = NetworkHelper();

  static Future<PaginationResponseModel<List<Bookmark>>?> getBookmarks(
      {int page = 1}) async {
    try {
      Response response = await _networkHelper.dio
          .get(RemoteRoutes.getBookmarks, queryParameters: {
        'page': page,
      });
      if (response.statusCode == 200) {
        return PaginationResponseModel.fromJson(
          response.data,
          (json) => (json as List<dynamic>)
              .map(
                (e) => Bookmark.fromJson(e),
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

  static Future<ApiResponseModel<List<Bookmark>>?> getMyProducts(
      String type) async {
    try {
      Response response = await _networkHelper.dio
          .get(RemoteRoutes.getMyProducts, queryParameters: {
        'type': type,
      });
      if (response.statusCode == 200) {
        return ApiResponseModel.fromJson(
          response.data,
          (json) => (json as List<dynamic>)
              .map(
                (e) => Bookmark.fromJson(e),
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

  static Future<bool> unBookmarkTutorial(String slug) async {
    try {
      Response response = await _networkHelper.dio.delete(
        RemoteRoutes.bookmarkTutorial(slug),
      );
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      return false;
    }
  }
}
