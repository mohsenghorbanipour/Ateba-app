import 'dart:io';

import 'package:ateba_app/core/base/base_box.dart';
import 'package:ateba_app/core/components/toast_component.dart';
import 'package:ateba_app/core/network/network_helper.dart';
import 'package:ateba_app/core/resources/models/cache_video_model.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class DownloadVideoBloc extends ChangeNotifier {
  factory DownloadVideoBloc() => _instance;
  DownloadVideoBloc._init();
  static final DownloadVideoBloc _instance = DownloadVideoBloc._init();

  static final NetworkHelper _networkHelper = NetworkHelper();

  final BaseBox<List> _cacheVideoBox = BaseBox('ateba_cache_video_box');

  List<CacheVideoModel> videos = [];

  int? percentage;
  bool downloading = false;

  CancelToken cancelToken = CancelToken();

  int? selectedVideoIdForDownload;

  Future<void> init() async {
    try {
      await _cacheVideoBox.open();
      final result = await _cacheVideoBox.first();
      if (result != null) {
        for (var e in result) {
          videos.add(e);
        }
      }
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> downloadVideoAndSave(CacheVideoModel cacheVideoModel) async {
    downloading = true;
    notifyListeners();
    try {
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;

      String fileName = cacheVideoModel.url?.split('/').last ?? '';
      String savePath = '$tempPath/$fileName';
      Response response = await _networkHelper.dio.download(
        cacheVideoModel.url ?? '',
        savePath,
        onReceiveProgress: (count, total) {
          percentage = ((count / total) * 100).floor();
          notifyListeners();
        },
        cancelToken: cancelToken,
      );
      if (response.statusCode == 200) {
        videos.add(
          CacheVideoModel(
            id: cacheVideoModel.id,
            slug: cacheVideoModel.slug,
            path: savePath,
            qality: cacheVideoModel.qality,
            size: cacheVideoModel.size,
            url: cacheVideoModel.url,
          ),
        );
        saveData();
      } else {
        ToastComponent.show(
          'faild_to_download'.tr(),
          type: ToastType.error,
        );
      }
      downloading = false;
      selectedVideoIdForDownload = null;
      notifyListeners();
      percentage = null;
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  void saveData() {
    try {
      _cacheVideoBox['mait'] = videos;
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  void cancelDownload() {
    try {
      cancelToken.cancel();
      downloading = false;
      percentage = 0;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  bool existVideoInCache(int id, String slug) {
    try {
      LoggerHelper.logger.wtf(id);
      LoggerHelper.logger.wtf(slug);
      LoggerHelper.logger.wtf(videos.first);
      bool exist = false;
      for (var e in videos) {
        if (e.id == id && e.slug == slug) {
          exist = true;
        }
      }
      return exist;
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      return false;
    }
  }
}
