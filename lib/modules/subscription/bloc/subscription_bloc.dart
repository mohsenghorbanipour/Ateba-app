import 'package:ateba_app/core/network/api_response_model.dart';
import 'package:ateba_app/core/utils/launcher_helper.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/cart/data/models/orders_response.dart';
import 'package:ateba_app/modules/subscription/data/models/subscription_plan.dart';
import 'package:ateba_app/modules/subscription/data/remote/subscription_remote_provider.dart';
import 'package:flutter/foundation.dart';

class SubscriptionBloc extends ChangeNotifier {
  bool loading = false;
  bool discountPreviewLoading = false;
  bool paymentLoading = false;

  List<SubscriptionPlan> plans = [];

  SubscriptionPlan? _selectedPlan;
  SubscriptionPlan? get selectedPlan => _selectedPlan;
  set selectedPlan(val) {
    _selectedPlan = val;
    notifyListeners();
  }

  OrdersResponse? ordersResponse;

  bool _applyCode = false;
  bool get applyCode => _applyCode;
  set applyCode(val) {
    _applyCode = val;
    notifyListeners();
  }

  Future<void> loadSubscriptionPlans() async {
    loading = true;
    notifyListeners();
    try {
      plans = await SubscriptionRemoteProvider.getSubscriptionPlans();
      loading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      loading = false;
      notifyListeners();
    }
  }

  Future<void> discountPreview(String discountCode) async {
    discountPreviewLoading = true;
    notifyListeners();
    try {
      ApiResponseModel<OrdersResponse>? response =
          await SubscriptionRemoteProvider.paymentOrdiscountPreview(
        selectedPlan!.id!,
        discountCode,
        isDiscountPreview: true,
      );
      if (response != null) {
        ordersResponse = response.data;
      }
      discountPreviewLoading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      discountPreviewLoading = false;
      notifyListeners();
    }
  }

  Future<void> payment() async {
    paymentLoading = true;
    notifyListeners();
    try {
      ApiResponseModel<OrdersResponse>? response =
          await SubscriptionRemoteProvider.paymentOrdiscountPreview(
        selectedPlan!.id!,
        (_applyCode && (ordersResponse?.discount_code?.isNotEmpty ?? false))
            ? (ordersResponse?.discount_code ?? '')
            : '',
      );
      if (response != null) {
        ordersResponse = response.data;
      }
      paymentLoading = false;
      notifyListeners();
      if (response?.data?.payment_link?.isNotEmpty ?? false) {
        LauncherHelper.launch(
          response?.data?.payment_link,
        );
      }
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      paymentLoading = false;
      notifyListeners();
    }
  }
}
