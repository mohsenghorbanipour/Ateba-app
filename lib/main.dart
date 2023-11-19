import 'dart:io';

import 'package:ateba_app/ateba_app.dart';
import 'package:ateba_app/core/resources/models/cache_video_model.dart';
import 'package:ateba_app/core/resources/notification%20service/notification_service.dart';
import 'package:ateba_app/core/utils/http_override.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/firebase_options.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage? message) async {
  //fcm
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = HttpOverride();

  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();

  Hive.registerAdapter(
    CacheVideoModelAdapter(),
  );

  await NotificationService().init();
  try {
    FirebaseMessaging.onBackgroundMessage(
      _firebaseMessagingBackgroundHandler,
    );
  } catch (e, s) {
    LoggerHelper.errorLog(e, s);
  }

  runApp(const AtebaApp());
}
