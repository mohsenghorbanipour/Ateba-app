import 'package:ateba_app/core/constants/remote_routes.dart';
import 'package:ateba_app/core/network/api_response_model.dart';
import 'package:ateba_app/core/network/network_helper.dart';
import 'package:ateba_app/core/network/pagination_response_model.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/comment.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/tutorial_details.dart';
import 'package:dio/dio.dart';

class TutorialDetaialsRemoteProvider {
  static final NetworkHelper _networkHelper = NetworkHelper();

  static Future<ApiResponseModel<TutorialDetaials>?> getToturialDetials(
      String slug) async {
    try {
      Response response = await _networkHelper.dio.get(
        RemoteRoutes.getTutorialDetails(slug),
      );
      if (response.statusCode == 200) {
        return ApiResponseModel.fromJson(
          response.data,
          (json) => TutorialDetaials.fromJson(json),
        );
      }
      return null;
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      return null;
    }
  }

  static Future<PaginationResponseModel<List<Comment>>?> getTutorialComments(
    String slug, {
    int? page,
  }) async {
    try {
      Response response = await _networkHelper.dio.get(
        RemoteRoutes.getTutorialComments(slug),
        queryParameters: {
          'page': page,
        }
      );
      if (response.statusCode == 200) {
        return PaginationResponseModel.fromJson(
          response.data,
          (json) => (json as List<dynamic>)
              .map(
                (e) => Comment.fromJson(e),
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

  static Future<void> sendComment(String slug) async {
    try {
      Response response = await _networkHelper.dio.post(
        RemoteRoutes.getTutorialComments(slug),
      );
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  static Future<bool> likeTutorial(String slug) async {
    try {
      Response response = await _networkHelper.dio.post(
        RemoteRoutes.likeTutorial(slug),
      );
      if(response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      return false;
    }
  }

  static Future<void> unlikeTutorial(String slug) async {
    try {
      Response response = await _networkHelper.dio.delete(
        RemoteRoutes.likeTutorial(slug),
      );
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  static Future<void> bookmarkTutorial(String slug) async {
    try {
      Response response = await _networkHelper.dio.post(
        RemoteRoutes.bookmarkTutorial(slug),
      );
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  static Future<void> unBookmarkTutorial(String slug) async {
    try {
      Response response = await _networkHelper.dio.delete(
        RemoteRoutes.bookmarkTutorial(slug),
      );
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }
}
