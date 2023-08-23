import 'package:ateba_app/core/constants/app_config.dart';
import 'package:ateba_app/core/router/ateba_router.dart';
import 'package:ateba_app/core/router/routes.dart';
import 'package:ateba_app/core/theme/bloc/theme_bloc.dart';
import 'package:ateba_app/modules/home/bloc/home_bloc.dart';
import 'package:ateba_app/modules/main/bloc/main_page_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:ateba_app/core/theme/style/ateba_theme.dart' as mytheme;

class AtebaApp extends StatelessWidget {
  const AtebaApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ThemeBloc(),
          ),
          ChangeNotifierProvider(
            create: (context) => MainPageBloc(),
          ),
          ChangeNotifierProvider(
            create: (context) => HomeBloc()..loadDate(),
            lazy: false,
          )
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
                  return MaterialApp(
                    title: AppConfig.appName,
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: context.locale,
                    builder: (context, child) {
                      child = myBuilder(context, child);
                      return child!;
                    },
                    initialRoute: Routes.main,
                    onGenerateRoute: AtebaRouter.router.generator,
                    debugShowCheckedModeBanner: false,
                    theme: mytheme.AtebaTheme.light,
                    themeMode: ThemeMode.light,
                    // darkTheme: mytheme.LiomTheme.light,
                    // theme: ThemeProvider.themeOf(context).data,
                  );
                }),
              ),
            ),
          ),
        ),
      );

  Widget? myBuilder(BuildContext context, Widget? child) {
    return Builder(
      builder: (context) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
        child: Builder(
          builder: (context) => Material(
            child: SafeArea(
              bottom: false,
              child: child ?? Container(),
            ),
          ),
        ),
      ),
    );
  }
}
