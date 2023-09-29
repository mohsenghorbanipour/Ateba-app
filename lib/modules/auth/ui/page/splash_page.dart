// ignore_for_file: use_build_context_synchronously

import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/router/routes.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    _initData();
    super.initState();
  }

  Future<void> _initData() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      GoRouter.of(context).goNamed(Routes.login);
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: ColorPalette.of(context).scaffoldBackground,
        body: Center(
          child: SvgPicture.asset(
            Assets.atebaLogo,
            width: 120,
          ),
        ),
      );
}
