import 'dart:async';
import 'dart:io';

import 'package:ateba_app/core/network/network_helper.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class VideoCacheManager {
  static final BaseCacheManager _cacheManager = DefaultCacheManager();

  static final NetworkHelper _networkHelper = NetworkHelper();

  static Future<VideoPlayerController?> getVideoController(
      String videoUrl) async {
    try {
      final fileInfo = await _cacheManager.getFileFromCache(videoUrl);
      if (fileInfo == null) {
        LoggerHelper.logger.i('video not exist in cache');
        unawaited(_cacheManager.downloadFile(videoUrl));
        return VideoPlayerController.networkUrl(
          Uri.parse(videoUrl),
        );
      } else {
        LoggerHelper.logger.i('video exist in cache');
        return VideoPlayerController.file(fileInfo.file);
      }
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      return null;
    }
  }

  static Future<void> downloadVideoAndSave(String videoUrl) async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;

      String fileName = videoUrl.split('/').last;
      String savePath = '$tempPath/$fileName';

      Response response = await _networkHelper.dio.download(
        videoUrl,
        savePath,
        onReceiveProgress: (count, total) {
          int percentage = ((count / total) * 100).floor();
        },
      );

      LoggerHelper.logger.w(response.data.toString());
      LoggerHelper.logger.w(savePath);
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }
}
