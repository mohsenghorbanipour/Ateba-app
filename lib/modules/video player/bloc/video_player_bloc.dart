import 'package:ateba_app/core/network/api_response_model.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/video.dart';
import 'package:ateba_app/modules/video%20player/data/models/video_chapter.dart';
import 'package:ateba_app/modules/video%20player/data/remote/video_player_remote_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerBloc extends ChangeNotifier {
  VideoPlayerBloc(String id, Video video) {
    initialVideoPlayer(
      video.hls_url ?? '',
    );
    loadVideoChapter(int.parse(id));
  }

  // Online Data
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

  // Offline Data For Controll Video Player

  VideoPlayerController? _controller;
  VideoPlayerController? get controller => _controller;

  bool initialized = false;

  Future<void> initialVideoPlayer(String url,
      {bool playFromOfflineGallery = false}) async {
    try {
      if (playFromOfflineGallery) {
      } else {
        _controller = VideoPlayerController.networkUrl(
          Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
        )..initialize();
      }
      initialized = true;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }
}
