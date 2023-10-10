import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/home/data/models/package.dart';
import 'package:flutter/foundation.dart';

enum TabState {
  educationalVideos,
  clinicalPackages,
}

class CategoriesBloc extends ChangeNotifier {
  // ==== Variables ==== //

  TabState _tabState = TabState.educationalVideos;
  TabState get tabState => _tabState;
  set tabState(val) {
    _tabState = val;
    notifyListeners();
  }

  bool packagesLoading = true;
  int? packagesCurrentPage;
  List<Package> packages = [];


  // ==== ==== //

  Future<void> getCategories() async {
    try {} catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  
}
