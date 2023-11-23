import 'package:ateba_app/core/network/api_response_model.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/fast%20search/data/models/fast_search.dart';
import 'package:ateba_app/modules/fast%20search/data/remote/fast_search_remote_provider.dart';
import 'package:flutter/foundation.dart';

class FastSearchBloc extends ChangeNotifier {
  bool loading = false;

  List<FastSearch> result = [];

  Future<void> search(String query) async {
    if (query.length > 2) {
      loading = true;
      notifyListeners();
      try {
        ApiResponseModel<List<FastSearch>?> response =
            await FaseSearchRemotePeovider.search(query);
        if (response.success ?? false) {
          result = response.data ?? [];
        }
        loading = false;
        notifyListeners();
      } catch (e, s) {
        LoggerHelper.errorLog(e, s);
        loading = false;
        notifyListeners();
      }
    }
  }
}
