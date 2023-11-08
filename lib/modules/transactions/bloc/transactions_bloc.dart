import 'package:ateba_app/core/network/api_response_model.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/transactions/data/models/transaction.dart';
import 'package:ateba_app/modules/transactions/data/remote/transactions_remote_provider.dart';
import 'package:flutter/foundation.dart';

class TransactionsBloc extends ChangeNotifier {
  bool loading = false;

  List<Transaction> transactions = [];

  Future<void> loadTransaction() async {
    loading = true;
    notifyListeners();
    try {
      ApiResponseModel<List<Transaction>>? response =
          await TransactionsRemoteProvider.getTransactions();
      if (response != null) {
        transactions = response.data ?? [];
      }
      loading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }
}
