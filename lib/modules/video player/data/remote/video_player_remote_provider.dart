import 'package:ateba_app/core/constants/remote_routes.dart';
import 'package:ateba_app/core/network/api_response_model.dart';
import 'package:ateba_app/core/network/network_helper.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/video%20player/data/models/video_chapter.dart';
import 'package:ateba_app/modules/video%20player/data/models/video_quiz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

class VideoPlayerRemoteProvider {
  static final NetworkHelper _networkHelper = NetworkHelper();

  static Future<ApiResponseModel<List<VideoChapter>>?> getVideoChapter(
      int id) async {
    try {
      Response response = await _networkHelper.dio.get(
        RemoteRoutes.getVideoChapter(id),
      );
      if (response.statusCode == 200) {
        return ApiResponseModel.fromJson(
          response.data,
          (json) => (json as List<dynamic>)
              .map(
                (e) => VideoChapter.fromJson(e),
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

  static Future<ApiResponseModel<List<VideoQuiz>?>> getVideoQuiz(int id) async {
    try {
      Response response = await _networkHelper.dio.get(
        RemoteRoutes.getVideoQuiz(id),
      );
      if (response.statusCode == 200) {
        return ApiResponseModel(
          success: true,
          message: response.data['message'],
          data: (response.data['data'] as List<dynamic>)
              .map((e) => VideoQuiz.fromJson(e))
              .toList(),
        );
      }
      return ApiResponseModel(
        success: false,
        message: response.data['message'],
        data: null,
      );
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      return ApiResponseModel(
        success: false,
        message: 'sth_wrong'.tr(),
        data: null,
      );
    }
  }

  static Future<void> answerQuestion(int id, int answerId) async {
    try {
      Response response = await _networkHelper.dio.get(
        RemoteRoutes.answerQuestion(id),
        data: {
          'choice_id': answerId,
        }
      );
      if (response.statusCode == 200) {}
      // return ApiResponseModel(
      //   success: false,
      //   message: response.data['message'],
      //   data: null,
      // );
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      // return ApiResponseModel(
      //   success: false,
      //   message: 'sth_wrong'.tr(),
      //   data: null,
      // );
    }
  }
}
