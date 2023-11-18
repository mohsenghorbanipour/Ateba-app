import 'package:ateba_app/core/constants/remote_routes.dart';
import 'package:ateba_app/core/network/api_response_model.dart';
import 'package:ateba_app/core/network/network_helper.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/cart/data/models/orders_response.dart';
import 'package:ateba_app/modules/subscription/data/models/subscription_plan.dart';
import 'package:dio/dio.dart';

class SubscriptionRemoteProvider {
  static final NetworkHelper _networkHelper = NetworkHelper();

  static Future<List<SubscriptionPlan>> getSubscriptionPlans() async {
    try {
      Response response = await _networkHelper.dio.get(
        RemoteRoutes.getSubscriptionPlans,
      );
      if (response.statusCode == 200) {
        return (response.data as List<dynamic>)
            .map(
              (json) => SubscriptionPlan.fromJson(json),
            )
            .toList();
      }
      return [];
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      return [];
    }
  }

  static Future<ApiResponseModel<OrdersResponse>?> paymentOrdiscountPreview(
      int id, String discountCode,
      {bool isDiscountPreview = false}) async {
    try {
      FormData data = FormData.fromMap(
        {
          'discount_code': discountCode,
          'discount_preview': isDiscountPreview ? 1 : 0,
        },
      );
      Response response = await _networkHelper.dio.post(
        RemoteRoutes.discountPreview(id),
        data: data,
      );
      if (response.statusCode == 200) {
        return ApiResponseModel.fromJson(
          response.data,
          (json) => OrdersResponse.fromJson(json),
        );
      }
      return null;
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      return null;
    }
  }
}
