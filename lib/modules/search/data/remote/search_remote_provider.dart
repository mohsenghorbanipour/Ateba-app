import 'package:ateba_app/core/constants/remote_routes.dart';
import 'package:ateba_app/core/network/api_response_model.dart';
import 'package:ateba_app/core/network/network_helper.dart';
import 'package:ateba_app/core/network/pagination_response_model.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/search/data/models/search_result.dart';
import 'package:dio/dio.dart';

class SearchRemotePeovider {
  static final NetworkHelper _networkHelper = NetworkHelper();

  static Future<PaginationResponseModel<List<SearchResult>>?> search(
    String query,
    String type,
    String key,
    {
      int page = 1,
    }
  ) async {
    try {
      Response response = await _networkHelper.dio.get(
        RemoteRoutes.advancedSearch,
        queryParameters: {
          'query': query,
          type: key,
          'page': page,
          'per_page': 20,
        },
      );
      if (response.statusCode == 200) {
        return PaginationResponseModel.fromJson(
          response.data,
          (json) => (json as List<dynamic>)
              .map(
                (e) => SearchResult.fromJson(e),
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
}
