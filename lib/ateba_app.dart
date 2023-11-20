import 'package:ateba_app/core/base/bloc/download_video_bloc.dart';
import 'package:ateba_app/core/constants/app_config.dart';
import 'package:ateba_app/core/router/ateba_router.dart';
import 'package:ateba_app/core/theme/bloc/theme_bloc.dart';
import 'package:ateba_app/modules/auth/bloc/auth_bloc.dart';
import 'package:ateba_app/modules/bookmarks/bloc/bookmarks_bloc.dart';
import 'package:ateba_app/modules/cart/bloc/cart_bloc.dart';
import 'package:ateba_app/modules/categories/bloc/categories_bloc.dart';
import 'package:ateba_app/modules/home/bloc/home_bloc.dart';
import 'package:ateba_app/modules/main/bloc/main_page_bloc.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:ateba_app/core/theme/style/ateba_theme.dart' as mytheme;

class AtebaApp extends StatelessWidget {
  const AtebaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();
    return MultiProvider(
      providers: [
        Provider<AtebaRouter>(
          lazy: false,
          create: (BuildContext createContext) => AtebaRouter(),
        ),
        ChangeNotifierProvider(
          create: (context) => DownloadVideoBloc()..init(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) => AuthBloc(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeBloc(),
        ),
        ChangeNotifierProvider(
          create: (context) => MainPageBloc(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoriesBloc(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeBloc(),
        ),
        ChangeNotifierProvider(
          create: (context) => BookmarksBloc()
            ..loadMyProduct(
              type: 'course',
            ),
        ),
        ChangeNotifierProvider(
          create: (context) => CartBloc(),
        ),
      ],
      child: EasyLocalization(
        supportedLocales: AppConfig.supportedLocales,
        path: AppConfig.localePath,
        startLocale: AppConfig.persianLocale,
        fallbackLocale: AppConfig.persianLocale,
        useOnlyLangCode: true,
        child: Builder(
          builder: (context) => ThemeProvider(
            defaultThemeId: context.select<ThemeBloc, String>(
                (bloc) => bloc.currentThemeNoSystem.toString()),
            themes: [
              AppTheme(
                  id: mytheme.theme.light.toString(),
                  description: '',
                  data: mytheme.AtebaTheme.light),
              AppTheme(
                id: mytheme.theme.dark.toString(),
                description: '',
                data: mytheme.AtebaTheme.dark,
              ),
            ],
            child: ThemeConsumer(
              child: Builder(builder: (context) {
                final GoRouter router =
                    Provider.of<AtebaRouter>(context, listen: false).router;
                return MaterialApp.router(
                  title: AppConfig.appName,
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  builder: (context, child) {
                    child = myBuilder(context, child);
                    child = botToastBuilder(context, child);
                    return child;
                  },
                  routeInformationParser: router.routeInformationParser,
                  routerDelegate: router.routerDelegate,
                  routeInformationProvider: router.routeInformationProvider,
                  debugShowCheckedModeBanner: false,
                  theme: ThemeProvider.themeOf(context).data,
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget? myBuilder(BuildContext context, Widget? child) {
    return Builder(
      builder: (context) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
        child: Builder(
          builder: (context) => Material(
            child: SafeArea(
              child: child ?? Container(),
            ),
          ),
        ),
      ),
    );
  }
}
