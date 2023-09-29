import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class LauncherHelper {
  /* static Future<bool> _canLaunchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      return true;
    } else {
      ToastComponent.show('can_not_launch_app'.tr());
      return false;
    }
  }*/

  static Future<void> launch(String? link, {bool inAppWebView = false}) async {
    LoggerHelper.logger.i(link);
    try {
      if (link != null || (link?.isNotEmpty ?? false)) {
        final uri = Uri.parse(link!);
        launchUrl(
          uri,
          mode: inAppWebView
              ? LaunchMode.inAppWebView
              : LaunchMode.externalApplication,
        );
      }
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }
}
