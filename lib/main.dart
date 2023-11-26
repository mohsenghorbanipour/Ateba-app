import 'dart:io';

import 'package:ateba_app/ateba_app.dart';
import 'package:ateba_app/core/resources/models/cache_video_model.dart';
import 'package:ateba_app/core/resources/notification%20service/notification_service.dart';
import 'package:ateba_app/core/utils/deeplink_callback.dart';
import 'package:ateba_app/core/utils/http_override.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/firebase_options.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uni_links/uni_links.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage? message) async {
  //fcm
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
}

Future<void> initUniLinks() async {
  // Check if the app was launched with a deep link
  String? initialLink;
  try {
    initialLink = await getInitialLink();
  } catch (e) {
    print('Error getting initial link: $e');
  }

  // Handle the initial deep link if it exists
  if (initialLink != null) {
    deepLinkCallBack(Uri.parse(initialLink));
  }

  // Listen for subsequent deep links
  // This will capture deep links when the app is already running
  linkStream.listen((String? link) {
    if (link != null) {
      deepLinkCallBack(Uri.parse(link));
    }
  });
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

  if (!kIsWeb) {
    await initUniLinks();
  }

  runApp(const AtebaApp());
}
