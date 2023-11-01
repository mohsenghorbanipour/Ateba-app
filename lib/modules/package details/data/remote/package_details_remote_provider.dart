import 'package:ateba_app/core/components/toast_component.dart';
import 'package:ateba_app/core/constants/remote_routes.dart';
import 'package:ateba_app/core/network/api_response_model.dart';
import 'package:ateba_app/core/network/network_helper.dart';
import 'package:ateba_app/core/network/pagination_response_model.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/cart/data/models/orders_response.dart';
import 'package:ateba_app/modules/package%20details/data/models/package_details.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/comment.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

class PackageDetailsRemoteProvider {
  static final NetworkHelper _networkHelper = NetworkHelper();

  static Future<ApiResponseModel<PackageDetails>?> getPackageDetials(
      String slug) async {
    try {
      Response response = await _networkHelper.dio.get(
        RemoteRoutes.getPackageDetials(
          slug,
        ),
      );
      if (response.statusCode == 200) {
        return ApiResponseModel.fromJson(
          response.data,
          (json) => PackageDetails.fromJson(
            json,
          ),
        );
      }
      return null;
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      return null;
    }
  }

  static Future<PaginationResponseModel<List<Comment>>?> getPackageComment(
      String slug) async {
    try {
      Response response = await _networkHelper.dio.get(
        RemoteRoutes.getPackageComments(slug),
      );
      if (response.statusCode == 200) {
        return PaginationResponseModel.fromJson(
          response.data,
          (json) => (json as List<dynamic>)
              .map(
                (e) => Comment.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
        );
      }
      return null;
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      return null;
    }
  }

  static Future<ApiResponseModel<OrdersResponse>?> orderPackage(
      String slug) async {
    try {
      Response response = await _networkHelper.dio.post(
        RemoteRoutes.orderPackage(slug),
      );
      if (response.statusCode == 200) {
        ToastComponent.show(
          'added_to_basket'.tr(),
          type: ToastType.success,
        );
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
