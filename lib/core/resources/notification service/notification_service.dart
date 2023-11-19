// ignore_for_file: avoid_redundant_argument_values, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:ateba_app/core/resources/notification%20service/recived_notification.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:http/http.dart' as http;
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/subjects.dart';

class NotificationService {
  factory NotificationService() => _instance;

  NotificationService._init();
  //!------------------------------------------------------------------------------------------------

  static final NotificationService _instance = NotificationService._init();
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  //!------------------------------------------------------------------------------------------------
  String? selectedNotificationPayload;
  //!------------------------------------------------------------------------------------------------
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  //!------------------------------------------------------------------------------------------------
  /// Streams are created so that app can respond to notification-related events
  /// since the plugin is initialised in the `main` function
  final BehaviorSubject<ReceivedNotification>
      didReceiveLocalNotificationSubject =
      BehaviorSubject<ReceivedNotification>();
  final BehaviorSubject<String?> selectNotificationSubject =
      BehaviorSubject<String?>();
  //!------------------------------------------------------------------------------------------------
  final AndroidInitializationSettings initializationSettingsAndroid =
      const AndroidInitializationSettings('app_icon');

  /// Note: permissions aren't requested here just to demonstrate that can be
  /// done later
  IOSInitializationSettings? initializationSettingsIOS;

  final MacOSInitializationSettings initializationSettingsMacOS =
      const MacOSInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );
  //!------------------------------------------------------------------------------------------------
  final AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.max,
  );
  //!------------------------------------------------------------------------------------------------
  NotificationAppLaunchDetails? notificationAppLaunchDetails;
  //!------------------------------------------------------------------------------------------------
  void _configureSelectNotificationSubject(BuildContext context) {
    selectNotificationSubject.stream.listen((String? payload) async {
      _handleNotificationsOnClick(context, payload);
    });
  }

  void _requestPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      // await showDialog(
      //   context: context,
      //   builder: (BuildContext context) => CupertinoAlertDialog(
      //     title: receivedNotification.title != null ? Text(receivedNotification.title!) : null,
      //     content: receivedNotification.body != null ? Text(receivedNotification.body!) : null,
      //     actions: <Widget>[
      //       CupertinoDialogAction(
      //         isDefaultAction: true,
      //         onPressed: () async {
      //           Navigator.of(context, rootNavigator: true).pop();
      //           await Navigator.push(
      //             context,
      //             MaterialPageRoute<void>(
      //               builder: (BuildContext context) => Container(
      //                 color: Colors.red,
      //               ),
      //             ),
      //           );
      //         },
      //         child: const Text('Ok'),
      //       )
      //     ],
      //   ),
      // );
    });
  }

  void configureLocalNotifications(BuildContext context) {
    _requestPermissions();
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject(context);
  }

  bool didNotificationLaunchApp = false;

  Future<void> init() async {
    notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      selectedNotificationPayload = notificationAppLaunchDetails?.payload;
      didNotificationLaunchApp =
          notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;
      debugPrint('${NotificationService().didNotificationLaunchApp}2');
    }
    initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (
        int id,
        String? title,
        String? body,
        String? payload,
      ) {
        didReceiveLocalNotificationSubject.add(
          ReceivedNotification(
            id: id,
            title: title,
            body: body,
            payload: payload,
          ),
        );
      },
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsMacOS,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        if (payload != null) {
          // ignore: avoid_print
          print('notification payload: $payload');
        }
        NotificationService().selectedNotificationPayload = payload;
        selectNotificationSubject.add(payload);
      },
    );
  }

  Future<void> initFcm(BuildContext context) async {
    /* On iOS, macOS & web, before FCM payloads can be received on your device,
       you must first ask the users permission. Android applications are not
       required to request permission */
    if (!Platform.isAndroid) {
      NotificationSettings settings = await firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      debugPrint('User granted permission: ${settings.authorizationStatus}');
    }
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleBackgroundMessage(initialMessage, context);
    }
    // Listen for get message
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        LoggerHelper.logger.wtf(message.notification?.title ?? '');

        try {
          _showNotification(message.notification!, message.data);
        } catch (e, s) {
          LoggerHelper.errorLog(e, s);
        }
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((mess) {
      LoggerHelper.logger.wtf(mess.data);

      _handleBackgroundMessage(mess, context);
    });
  }

  Future<void> _notificationHandler(
    BuildContext context,
    Map<String, dynamic> notification,
  ) async {
    try {} catch (e, s) {
      LoggerHelper.errorLog(e, s);
      BotToast.closeAllLoading();
    }
  }

  Future<void> _handleBackgroundMessage(
      RemoteMessage message, BuildContext context) async {
    try {
      // BotToast.showLoading();
      // await Future.delayed(const Duration(seconds: 4));
      BotToast.closeAllLoading();
      LoggerHelper.logger.wtf(message.data);

      // var notification = NotificationModel.fromNotif(message.data);
      LoggerHelper.logger.wtf('dattttta ${message.data}');
      await _notificationHandler(context, message.data);
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> _handleNotificationsOnClick(
      BuildContext context, String? payload) async {
    try {
      LoggerHelper.logger.wtf(payload);
      if (payload != null) {
        // var notification = NotificationModel.fromNotif(
        //     json.decode(payload) as Map<String, dynamic>);
        await _notificationHandler(
          context,
          json.decode(payload),
        );
      }
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<String?> _downloadAndSaveNotifImage(
      String url, String fileName) async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final String filePath = '${directory.path}/$fileName';
      final http.Response response = await http.get(Uri.parse(url));
      final File file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return filePath;
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      return null;
    }
  }

  // ignore: strict_raw_type
  Future<void> _showNotification(
      RemoteNotification notification, Map data) async {
    String? largeIconPath;
    String? bigPicturePath;
    BigPictureStyleInformation? bigPictureStyleInformation;
    if (data['badge'] != null && data['badge'] is String) {
      largeIconPath = await _downloadAndSaveNotifImage(
          data['badge'] as String, 'largeIcon');
      bigPicturePath = await _downloadAndSaveNotifImage(
          data['badge'] as String, 'bigPicture');
      bigPictureStyleInformation = BigPictureStyleInformation(
          FilePathAndroidBitmap(bigPicturePath ?? ''),
          largeIcon: FilePathAndroidBitmap(largeIconPath ?? ''),
          contentTitle: notification.title,
          htmlFormatContentTitle: true,
          summaryText: notification.body,
          htmlFormatSummaryText: true);
    }
    await flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id, channel.name,
          channelDescription: channel.description,
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
          playSound: true,
          color: ColorPalette.light.primary,
          channelShowBadge: true,
          styleInformation: bigPictureStyleInformation,
          largeIcon: largeIconPath != null
              ? FilePathAndroidBitmap(largeIconPath)
              : null,
          // icon: FilePathAndroidBitmap(largeIconPath)
        ),
      ),
      payload: json.encode(data),
    );
  }
}
