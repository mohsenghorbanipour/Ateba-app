import 'package:ateba_app/core/constants/remote_routes.dart';
import 'package:ateba_app/core/network/api_response_model.dart';
import 'package:ateba_app/core/network/network_helper.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/cart/data/models/orders_response.dart';
import 'package:dio/dio.dart';

class CartRemoteProvider {
  static final NetworkHelper _networkHelper = NetworkHelper();

  static Future<ApiResponseModel<OrdersResponse>?> getOrders() async {
    try {
      Response response = await _networkHelper.dio.get(
        RemoteRoutes.getOrders,
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

  static Future<OrdersResponse?> deleteOrder(String id) async {
    try {
      Response response = await _networkHelper.dio.delete(
        RemoteRoutes.deleteOrder(id),
      );
      if (response.statusCode == 200) {
        return OrdersResponse.fromJson(
          response.data['data']['invoice'],
        );
      }
      return null;
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      return null;
    }
  }

  static Future<ApiResponseModel<OrdersResponse>?> applyDiscount(
      String discountCode) async {
    try {
      Response response =
          await _networkHelper.dio.post(RemoteRoutes.applyDiscount, data: {
        'discount_code': discountCode,
      });
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

  static Future<String?> payment() async {
    try {
      Response response = await _networkHelper.dio.get(
        RemoteRoutes.payment,
      );
      if (response.statusCode == 200) {
        return response.data['payment_link'];
      }
      return null;
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      return null;
    }
  }
}
