import 'package:ateba_app/core/constants/remote_routes.dart';
import 'package:ateba_app/core/network/api_response_model.dart';
import 'package:ateba_app/core/network/network_helper.dart';
import 'package:ateba_app/core/network/pagination_response_model.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/course%20details/data/models/course_details.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/comment.dart';
import 'package:dio/dio.dart';

class CourseDetailsRemoteProvider {
  static final NetworkHelper _networkHelper = NetworkHelper();

  static Future<ApiResponseModel<CourseDetails>?> getCourseDetails(
      String slug) async {
    try {
      Response response = await _networkHelper.dio.get(
        RemoteRoutes.getCourseDetails(slug),
      );
      if (response.statusCode == 200) {
        return ApiResponseModel.fromJson(
          response.data,
          (json) => CourseDetails.fromJson(json),
        );
      }
      return null;
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      return null;
    }
  }

  static Future<PaginationResponseModel<List<Comment>>?> getCourseComment(
      String slug) async {
    try {
      Response response = await _networkHelper.dio.get(
        RemoteRoutes.getCourseComment(slug),
      );
      if (response.statusCode == 200) {
        return PaginationResponseModel.fromJson(
          response.data,
          (json) => (json as List<dynamic>)
              .map(
                (e) => Comment.fromJson(e as Map<String, dynamic>),
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

  static Future<ApiResponseModel<Comment>?> sendComment(
    String slug,
    String comment, {
    int? replyTo,
  }) async {
    FormData data = FormData.fromMap(
      {
        'content': comment,
        'reply_to': replyTo,
      },
    );
    try {
      Response response = await _networkHelper.dio.post(
        RemoteRoutes.getTutorialComments(slug),
        data: data,
      );
      if (response.statusCode == 200) {
        return ApiResponseModel.fromJson(
          response.data,
          (json) => Comment.fromJson(
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
