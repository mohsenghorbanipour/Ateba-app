import 'package:ateba_app/modules/package%20details/ui/widgets/lessons_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum TabState {
  lessons,
  descriptions,
  teachers,
  comments,
}

class PackageDetailsBloc extends ChangeNotifier {

  TabState _tabState = TabState.lessons;
  TabState get tabState => _tabState;
  set tabState(val) {
    _tabState = val;
    notifyListeners();
  }

}
