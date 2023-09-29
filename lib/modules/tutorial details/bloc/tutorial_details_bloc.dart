import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/tutorial%20details/data/remote/tutorial_details_remote_provider.dart';
import 'package:flutter/foundation.dart';

class TutorialDetaialsBloc extends ChangeNotifier {

  Future<void> loadToturialDetials(String slug) async {
    try {
      await TutorialDetaialsRemoteProvider.getToturialDetials(slug);
    } catch(e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

}