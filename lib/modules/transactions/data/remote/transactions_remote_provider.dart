import 'package:ateba_app/core/constants/remote_routes.dart';
import 'package:ateba_app/core/network/api_response_model.dart';
import 'package:ateba_app/core/network/network_helper.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/transactions/data/models/transaction.dart';
import 'package:dio/dio.dart';

class TransactionsRemoteProvider {
  static final NetworkHelper _networkHelper = NetworkHelper();

  static Future<ApiResponseModel<List<Transaction>>?> getTransactions() async {
    try {
      Response response = await _networkHelper.dio.get(
        RemoteRoutes.getTransactions,
      );
      if (response.statusCode == 200) {
        return ApiResponseModel.fromJson(
          response.data,
          (json) => (json as List<dynamic>)
              .map((e) => Transaction.fromJson(e))
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
