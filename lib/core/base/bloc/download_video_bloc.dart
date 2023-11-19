import 'dart:io';
import 'dart:math';

import 'package:ateba_app/core/base/base_box.dart';
import 'package:ateba_app/core/components/toast_component.dart';
import 'package:ateba_app/core/network/network_helper.dart';
import 'package:ateba_app/core/resources/models/cache_video_model.dart';
import 'package:ateba_app/core/resources/notification%20service/notification_service.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';

class DownloadVideoBloc extends ChangeNotifier {
  factory DownloadVideoBloc() => _instance;
  DownloadVideoBloc._init();
  static final DownloadVideoBloc _instance = DownloadVideoBloc._init();

  static final NetworkHelper _networkHelper = NetworkHelper();

  final BaseBox<List> _cacheVideoBox = BaseBox('ateba_cache_video_box');

  List<CacheVideoModel> videos = [];

  int percentage = 0;
  bool downloading = false;

  CancelToken cancelToken = CancelToken();

  int? _selectedVideoIdForDownload;
  int? get selectedVideoIdForDownload => _selectedVideoIdForDownload;
  set selectedVideoIdForDownload(val) {
    _selectedVideoIdForDownload = val;
    notifyListeners();
  }

  int? selectedVideoIndexForDownload;

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
      // Directory? tempDir = await getExternalStorageDirectory();
      Directory? tempDir = await getApplicationCacheDirectory();
      String tempPath = tempDir.path;

      String number = '';
      Random random = Random();
      for (var i = 0; i < 16; i++) {
        number = number + random.nextInt(9).toString();
      }

      String fileName = cacheVideoModel.url?.split('/').last ?? '';
      String savePath = '$tempPath/$number$fileName';
      Response response = await _networkHelper.dio.download(
        cacheVideoModel.url ?? '',
        savePath,
        onReceiveProgress: (count, total) {
          percentage = ((count / total) * 100).floor();
          updateNotification(percentage);
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
            duration: cacheVideoModel.duration,
            thumbnail_url: cacheVideoModel.thumbnail_url,
            title: cacheVideoModel.title,
            updated_at: cacheVideoModel.updated_at,
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
      selectedVideoIndexForDownload = null;
      selectedVideoIdForDownload = null;
      notifyListeners();
      percentage = 0;
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  void updateNotification(int progress) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
      onlyAlertOnce: true,
      showProgress: true, // Show the progress indicator in the notification
      maxProgress: 100, // The maximum value of the progress indicator
      progress: progress, // The current progress value
    );

    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await NotificationService.flutterLocalNotificationsPlugin.show(
      0,
      'Download Video',
      'Downloading ...',
      platformChannelSpecifics,
    );
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
      selectedVideoIndexForDownload = null;
      selectedVideoIdForDownload = null;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  bool existVideoInCache(int id, String slug) {
    try {
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

  String getPath(int id, slug) {
    try {
      String path = '';
      for (var e in videos) {
        if (e.id == id && e.slug == slug) {
          path = e.path ?? '';
        }
      }
      return path;
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      return '';
    }
  }

  CacheVideoModel getVideoFromId(int id) {
    return videos.firstWhere((e) => e.id == id);
  }
}
