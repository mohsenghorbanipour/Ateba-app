import 'package:ateba_app/core/constants/remote_routes.dart';
import 'package:ateba_app/core/network/api_response_model.dart';
import 'package:ateba_app/core/network/network_helper.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/video%20player/data/models/video_chapter.dart';
import 'package:dio/dio.dart';

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
}
