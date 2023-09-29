import 'package:ateba_app/core/constants/remote_routes.dart';
import 'package:ateba_app/core/network/network_helper.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';

class TutorialDetaialsRemoteProvider {
  static final NetworkHelper _networkHelper = NetworkHelper();

  static Future<void> getToturialDetials(String slug) async {
    try {
      await _networkHelper.dio.get(
        RemoteRoutes.getTutorialDetails(slug),
      );
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }
}
