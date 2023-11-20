import 'package:ateba_app/core/components/toast_component.dart';
import 'package:ateba_app/core/constants/remote_routes.dart';
import 'package:ateba_app/core/network/api_response_model.dart';
import 'package:ateba_app/core/network/network_helper.dart';
import 'package:ateba_app/core/network/pagination_response_model.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/notifications/data/models/notification.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

class NotificationRemoteProvider {
  static final NetworkHelper _networkHelper = NetworkHelper();

  static Future<PaginationResponseModel<List<Notification>>?> getNotifications(
      {int page = 1}) async {
    try {
      Response response = await _networkHelper.dio.get(
        RemoteRoutes.getNotifications,
        queryParameters: {
          'page': page,
        }
      );
      if (response.statusCode == 200) {
        return PaginationResponseModel.fromJson(
          response.data,
          (json) => (json as List<dynamic>)
              .map(
                (e) => Notification.fromJson(e),
              )
              .toList(),
        );
      }
      if (response.data['message'] != null) {
        ToastComponent.show(response.data['message']);
      }
      return null;
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      ToastComponent.show('sth_wrong'.tr());
      return null;
    }
  }
}
