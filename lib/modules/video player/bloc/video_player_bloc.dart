import 'dart:io';
import 'dart:math';
import 'package:ateba_app/core/network/api_response_model.dart';
import 'package:ateba_app/core/resources/cache%20provider/config_box.dart';
import 'package:ateba_app/core/router/ateba_router.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/video.dart';
import 'package:ateba_app/modules/video%20player/data/models/video_chapter.dart';
import 'package:ateba_app/modules/video%20player/data/models/video_quiz.dart';
import 'package:ateba_app/modules/video%20player/data/remote/video_player_remote_provider.dart';
import 'package:ateba_app/modules/video%20player/ui/modals/quiz_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerBloc extends ChangeNotifier {
  VideoPlayerBloc(String id, Video video) {
    videoId = int.parse(id);
    loadVideoChapter(int.parse(id));
    loadVideoQuiz(int.parse(id));
  }

  // Online Data
  bool answerQuestionLoading = false;

  int? videoId;

  bool loading = false;
  List<VideoChapter> chapters = [];

  List<VideoQuiz> quizes = [];
  List<int> showedVideoId = [];

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

  Future<void> loadVideoQuiz(int id) async {
    try {
      ApiResponseModel<List<VideoQuiz>?> response =
          await VideoPlayerRemoteProvider.getVideoQuiz(id);
      if (response.success ?? false) {
        quizes = response.data ?? [];
      }
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> answerQuestion(int id, int answerId) async {
    answerQuestionLoading = true;
    notifyListeners();
    try {
      await VideoPlayerRemoteProvider.answerQuestion(id, answerId);
      answerQuestionLoading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      answerQuestionLoading = false;
      notifyListeners();
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

  bool _showArrowLeft = false;
  bool get showArrowLeft => _showArrowLeft;
  Future<void> setShowArrowLeft() async {
    _showArrowLeft = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    _showArrowLeft = false;
    notifyListeners();
  }

  bool _showArrowRight = false;
  bool get showArrowRight => _showArrowRight;
  Future<void> setShowArrowRight() async {
    _showArrowRight = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    _showArrowRight = false;
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
      {bool playFromOfflineGallery = false, String cacheQuality = ''}) async {
    try {
      int lastDuration = await getLastPlayTime();
      if (playFromOfflineGallery) {
        final controller = VideoPlayerController.file(
          File(url),
        );
        _controller = controller;
        selectedQuality = cacheQuality;
        notifyListeners();
        _controller?.initialize().then(
          (_) async {
            _controller?.addListener(() {
              onControllerUpdata();
            });
          },
        );
      } else {
        final controller = VideoPlayerController.networkUrl(
          Uri.parse(url),
        );
        _controller = controller;
        notifyListeners();
        _controller?.initialize().then(
          (_) {
            _controller?.seekTo(Duration(seconds: lastDuration));
            _controller?.addListener(() {
              onControllerUpdata();
            });
          },
        );
      }
      initialized = true;
      await playOrPauseVideo();
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
      for (var e in quizes) {
        if (((duration ?? 0) - (remained ?? 0)) < (e.at_second ?? -1)) {
          if (showedVideoId.contains(e.id)) {
            showedVideoId.remove(e.id);
          }
        }
        if (e.at_second == ((duration ?? 0) - (remained ?? 0))) {
          if (!showedVideoId.contains(e.id)) {
            showQuizeModal(quizes.indexOf(e));
          }
          showedVideoId.add(e.id ?? -1);
        }
      }
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

  void setPlaybackSpeed(double speed) {
    _controller?.setPlaybackSpeed(speed);
  }

  Future<int> getLastPlayTime() async {
    try {
      return int.parse(await ConfigBox.getConfig(videoId.toString()) ?? '0');
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      return 0;
    }
  }

  void showQuizeModal(int index) {
    try {
      BuildContext context = AtebaRouter.navigatorKey.currentContext!;
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (ctx) => ChangeNotifierProvider.value(
          value: this,
          builder: (ctx, child) => QuizModal(
            videoQuiz: quizes[index],
          ),
        ),
      );
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  @override
  void dispose() {
    ConfigBox.setConfig(
      videoId.toString(),
      ((duration ?? 0) - (remained ?? 0)).toString(),
    );
    _controller?.dispose();
    super.dispose();
  }
}
