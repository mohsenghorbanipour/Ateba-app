import 'package:ateba_app/core/network/pagination_response_model.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/notifications/data/models/notification.dart';
import 'package:ateba_app/modules/notifications/data/remote/notification_remote_provider.dart';
import 'package:flutter/foundation.dart';

class NotificationBloc extends ChangeNotifier {
  bool loading = false;
  bool loadingMore = false;

  int? currentPage;
  bool canLoadMore = true;

  List<Notification> notifications = [];

  Future<void> loadNotifications() async {
    loading = true;
    notifyListeners();
    try {
      PaginationResponseModel<List<Notification>>? response =
          await NotificationRemoteProvider.getNotifications();
      if (response != null) {
        notifications = response.data ?? [];
        currentPage = response.meta?.current_page ?? 1;
        canLoadMore = response.links?.next?.isNotEmpty ?? false;
      }
      loading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      loadingMore = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreNotifications() async {
    loadingMore = true;
    notifyListeners();
    try {
      PaginationResponseModel<List<Notification>>? response =
          await NotificationRemoteProvider.getNotifications(
        page: (currentPage ?? 0) + 1,
      );
      if (response != null) {
        notifications.addAll(response.data ?? []);
        currentPage = response.meta?.current_page ?? 1;
        canLoadMore = response.links?.next?.isNotEmpty ?? false;
      }
      loadingMore = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      loadingMore = false;
      notifyListeners();
    }
  }
}
