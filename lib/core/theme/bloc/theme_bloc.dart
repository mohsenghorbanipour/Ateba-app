// ignore_for_file: use_build_context_synchronously

import 'package:ateba_app/core/theme/data/theme_cache.dart';
import 'package:ateba_app/core/theme/style/ateba_theme.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theme_provider/theme_provider.dart';

class ThemeBloc extends ChangeNotifier {
  ThemeBloc() {
    loadCurrentTheme();
  }

  String _currentThemeId = theme.system.toString();

  theme get currentTheme {
    if (_currentThemeId == theme.light.toString()) {
      return theme.light;
    } else if (_currentThemeId == theme.dark.toString()) {
      return theme.dark;
    } else {
      return theme.system;
    }
  }

  theme get currentThemeNoSystem {
    String themeIdNoSystem = _currentThemeId == theme.system.toString()
        ? AtebaTheme.getThemeIdBySystem()
        : _currentThemeId;
    if (themeIdNoSystem == theme.light.toString()) {
      return theme.light;
    } else {
      return theme.dark;
    }
  }

  set currentTheme(theme value) {
    _currentThemeId = value.toString();
    notifyListeners();
  }

  bool isThemeSelected(theme value) => currentTheme == value;

  Future<String> loadCurrentTheme() async {
    _currentThemeId = await ThemeCache.getThemeId();
    notifyListeners();
    if (_currentThemeId == theme.light.toString()) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
      );
    } else {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
      );
    }
    return _currentThemeId;
  }

  Future<void> loadAndApplyTheme(BuildContext context) async {
    _currentThemeId = await ThemeCache.getThemeId();
    ThemeProvider.controllerOf(context)
        .setTheme(currentThemeNoSystem.toString());
    notifyListeners();
  }

  void setNewTheme(BuildContext context, String newThemeId) {
    try {
      _currentThemeId = newThemeId;
      notifyListeners();
      ThemeCache.setThemeId(newThemeId);
      if (newThemeId == theme.system.toString()) {
        String theme = AtebaTheme.getThemeIdBySystem();
        if (theme == 'ThemeMode.light') {
          ThemeProvider.controllerOf(context).setTheme('theme.light');
        } else {
          ThemeProvider.controllerOf(context).setTheme('theme.dark');
        }
      } else {
        ThemeProvider.controllerOf(context).setTheme(newThemeId);
      }
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> onSystemBrightnessChanged(
      BuildContext context, Brightness brightness) async {
    await loadCurrentTheme();
    if (currentTheme == theme.system) {
      if (brightness == Brightness.light) {
        ThemeProvider.controllerOf(context).setTheme(theme.light.toString());
      } else if (brightness == Brightness.dark) {
        ThemeProvider.controllerOf(context).setTheme(theme.dark.toString());
      }
    }
  }
}