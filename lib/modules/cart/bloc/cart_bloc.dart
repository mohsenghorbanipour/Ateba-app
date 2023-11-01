import 'package:ateba_app/core/network/api_response_model.dart';
import 'package:ateba_app/core/utils/launcher_helper.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/cart/data/models/orders_response.dart';
import 'package:ateba_app/modules/cart/data/remote/cart_remote_provider.dart';
import 'package:flutter/foundation.dart';

class CartBloc extends ChangeNotifier {
  factory CartBloc() => _instance;
  CartBloc._init();
  static final CartBloc _instance = CartBloc._init();

  bool loading = false;
  bool applyDiscountLoading = false;
  bool paymentLoading = false;

  OrdersResponse? _ordersResponse;
  OrdersResponse? get ordersResponse => _ordersResponse;
  set ordersResponse(val) {
    _ordersResponse = val;
    notifyListeners();
  }

  Future<void> loadOrders() async {
    loading = true;
    notifyListeners();
    try {
      ApiResponseModel<OrdersResponse>? response =
          await CartRemoteProvider.getOrders();
      if (response != null) {
        ordersResponse = response.data;
      }
      loading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> deleteOrder(String orderId) async {
    try {
      OrdersResponse? response = await CartRemoteProvider.deleteOrder(orderId);
      if (response != null) {
        ordersResponse = response;
      }
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> applyDiscount(String discountCode) async {
    applyDiscountLoading = true;
    notifyListeners();
    try {
      ApiResponseModel<OrdersResponse>? response =
          await CartRemoteProvider.applyDiscount(discountCode);
      if (response != null) {
        ordersResponse = response.data;
      }
      applyDiscountLoading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> payment() async {
    paymentLoading = true;
    notifyListeners();
    try {
      String? paymentLink = await CartRemoteProvider.payment();
      if (paymentLink?.isNotEmpty ?? false) {
        LauncherHelper.launch(paymentLink);
      }
      paymentLoading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  bool checkExistOrderInCart(String type, String slug) {
    bool isExist = false;
    ordersResponse?.orders?.forEach(
      (e) {
        if (e.link_to?.type == type && e.link_to?.slug == slug) {
          isExist = true;
        }
      },
    );
    return isExist;
  }
}
