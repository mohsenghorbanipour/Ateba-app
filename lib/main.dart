import 'package:ateba_app/ateba_app.dart';
import 'package:ateba_app/core/router/ateba_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  
  await Hive.initFlutter();

  AtebaRouter.setupRouter();

  runApp(const AtebaApp());
}
