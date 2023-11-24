import 'package:ateba_app/core/constants/remote_routes.dart';
import 'package:ateba_app/core/network/api_response_model.dart';
import 'package:ateba_app/core/network/network_helper.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/fast%20search/data/models/fast_search.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

class FaseSearchRemotePeovider {
  static final NetworkHelper _networkHelper = NetworkHelper();

  static Future<ApiResponseModel<List<FastSearch>?>> search(String query,
      {bool isSuggested = false}) async {
    try {
      Response response = await _networkHelper.dio.get(
        RemoteRoutes.searchFase,
        queryParameters: {
          'query': query,
          'is_suggested': isSuggested,
        },
      );
      if (response.statusCode == 200) {
        return ApiResponseModel(
          success: true,
          message: response.data['message'],
          data: (response.data['data'] as List<dynamic>)
              .map((e) => FastSearch.fromJson(e))
              .toList(),
        );
      }
      return ApiResponseModel(
        success: false,
        message: response.data['message'],
        data: null,
      );
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      return ApiResponseModel(
        success: false,
        message: 'sth_wrong'.tr(),
        data: null,
      );
    }
  }
}
