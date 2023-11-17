import 'dart:math';

import 'package:ateba_app/core/network/api_response_model.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/video.dart';
import 'package:ateba_app/modules/video%20player/data/models/video_chapter.dart';
import 'package:ateba_app/modules/video%20player/data/remote/video_player_remote_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerBloc extends ChangeNotifier {
  VideoPlayerBloc(String id, Video video) {
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
  bool isPlaying = false;

  bool _showOptions = false;
  bool get showOptions => _showOptions;
  Future<void> setShowOption() async {
    if (_showOptions) {
      _showOptions = false;
      notifyListeners();
    } else {
      _showOptions = true;
      notifyListeners();
      await Future.delayed(const Duration(seconds: 4));
      _showOptions = false;
      notifyListeners();
    }
  }

  bool _fullScreen = false;
  bool get fullScreen => _fullScreen;
  set fullScreen(val) {
    _fullScreen = val;
    notifyListeners();
  }

  int? onUpdateControllerTime;

  int? duration;
  int? head;
  int? remained;
  String? hour;
  String? mins;
  String? sec;

  double progress = 0.0;

  String selectedQuality = 'auto';

  Future<void> initialVideoPlayer(String url,
      {bool playFromOfflineGallery = false}) async {
    try {
      if (playFromOfflineGallery) {
      } else {
        final controller = VideoPlayerController.networkUrl(
          Uri.parse(url),
        );
        _controller = controller;
        notifyListeners();
        _controller?.initialize().then(
          (_) {
            _controller?.addListener(() {
              onControllerUpdata();
            });
          },
        );
      }
      initialized = true;
      playOrPauseVideo();
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  String convertTo(int value) {
    return value < 10 ? '0$value' : '$value';
  }

  void setProgress(double value) {
    progress = value * 0.01;
    notifyListeners();
  }

  Future<void> playOrPauseVideo() async {
    try {
      if (isPlaying) {
        await _controller?.pause();
        isPlaying = false;
        notifyListeners();
      } else {
        isPlaying = true;
        await _controller?.play();
        duration = controller?.value.duration.inSeconds ?? 0;
        head = _controller?.value.position.inSeconds ?? 0;
        remained = max(0, (duration ?? 0) - (head ?? 0));
        hour = convertTo(((remained ?? 0) ~/ 60.0) ~/ 60);
        mins = convertTo((remained ?? 0) ~/ 60.0);
        if (int.parse(mins ?? '0') > 60) {
          mins = (int.parse(mins ?? '0') % 60).toString();
        }
        sec = convertTo((remained ?? 0) % 60);
        notifyListeners();
      }
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  void onControllerUpdata() {
    try {
      onUpdateControllerTime = 0;
      final now = DateTime.now().millisecondsSinceEpoch;
      if (onUpdateControllerTime! > now) {
        return;
      }
      onUpdateControllerTime = now + 500;
      final controller = _controller;
      if (controller == null) {
        return;
      }
      if (!controller.value.isInitialized) {
        LoggerHelper.logger.i('controller can not be initialized');
        return;
      }

      final playing = controller.value.isPlaying;
      isPlaying = playing;
      duration = controller.value.duration.inSeconds;
      head = _controller?.value.position.inSeconds ?? 0;
      remained = max(0, (duration ?? 0) - (head ?? 0));
      hour = convertTo(((remained ?? 0) ~/ 60.0) ~/ 60);
      mins = convertTo((remained ?? 0) ~/ 60.0);
      if (int.parse(mins ?? '0') > 60) {
        mins = (int.parse(mins ?? '0') % 60).toString();
      }
      sec = convertTo((remained ?? 0) % 60);
      progress =
          (_controller?.value.position.inMilliseconds.ceilToDouble() ?? 0) /
              controller.value.duration.inMilliseconds.ceilToDouble();
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> changeVideoQuality(String url, String quality) async {
    initialized = false;
    _controller?.pause();
    isPlaying = false;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    var controller = _controller;
    await initialVideoPlayer(
      url,
    );
    await Future.delayed(
      const Duration(seconds: 1),
    );
    controller?.dispose();
    initialized = true;
    selectedQuality = quality;
    notifyListeners();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
