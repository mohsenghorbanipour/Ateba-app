// ignore_for_file: use_build_context_synchronously

import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/resources/notification%20service/notification_service.dart';
import 'package:ateba_app/core/router/routes.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/auth/bloc/auth_bloc.dart';
import 'package:ateba_app/modules/cart/bloc/cart_bloc.dart';
import 'package:ateba_app/modules/categories/bloc/categories_bloc.dart';
import 'package:ateba_app/modules/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
      NotificationService().initFcm(context);
      NotificationService().configureLocalNotifications(context);
      await AuthBloc().init().then(
        (_) async {
          if (AuthBloc().isLogin) {
            AuthBloc().loadData();
            Provider.of<HomeBloc>(context, listen: false).loadData();
            CategoriesBloc().loadCategories();
            CartBloc().loadOrders();
            context.goNamed(
              Routes.main,
            );
          } else {
            context.goNamed(
              Routes.login,
            );
          }
        },
      );
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
