import 'package:ateba_app/core/network/api_response_model.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/video%20player/data/models/video_chapter.dart';
import 'package:ateba_app/modules/video%20player/data/remote/video_player_remote_provider.dart';
import 'package:flutter/foundation.dart';

class VideoPlayerBloc extends ChangeNotifier {
  VideoPlayerBloc(int id) {
    loadVideoChapter(id);
  }

  bool loading = false;

  List<VideoChapter> chapters = [];

  Future<void> loadVideoChapter(int id) async {
    loading = true;
    notifyListeners();
    try {
      ApiResponseModel<List<VideoChapter>>? response =
          await VideoPlayerRemoteProvider.getVideoChapter(id);
      if (response != null) {
        chapters = response.data ?? [];
      }
      loading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }
}
