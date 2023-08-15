import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/core/theme/style/ateba_theme.dart';
import '../../resources/cache provider/config_box.dart';

class ThemeCache {
  static const String _themeIdKey = 'theme-mode-ateba-id';

  static Future<void> setThemeId(String? id) async {
    try {
      await ConfigBox.setConfig(_themeIdKey, id);
    } catch (e) {
      LoggerHelper.logger.e(e);
    }
  }

  static Future<String> getThemeId() async {
    String? baseUrl = await ConfigBox.getConfig(_themeIdKey);
    return baseUrl ?? theme.light.toString();
  }
}
