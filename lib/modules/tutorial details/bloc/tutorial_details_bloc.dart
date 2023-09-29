import 'package:ateba_app/core/network/api_response_model.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/tutorial_details.dart';
import 'package:ateba_app/modules/tutorial%20details/data/remote/tutorial_details_remote_provider.dart';
import 'package:flutter/foundation.dart';

class TutorialDetaialsBloc extends ChangeNotifier {
  TutorialDetaialsBloc(String slug) {
    loadToturialDetials(slug);
  }

  bool loading = true;
  TutorialDetaials? tutorialDetaials;

  Future<void> loadToturialDetials(String slug) async {
    try {
      ApiResponseModel<TutorialDetaials>? response =
          await TutorialDetaialsRemoteProvider.getToturialDetials(slug);
      if (response != null) {
        tutorialDetaials = response.data;
      }
      loading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }
}
