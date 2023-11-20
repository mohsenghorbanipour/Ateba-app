import 'package:flutter/foundation.dart';

class TextViewerBloc extends ChangeNotifier {
  static const double maxTextSize = 24;
  static const double minTextSize = 12;

  bool _darkMode = false;
  bool get darkMode => _darkMode;
  set darkMode(val) {
    _darkMode = val;
    notifyListeners();
  }

  double textSize = 16;

  void increaseTextSize() {
    if (textSize < maxTextSize) {
      textSize++;
      notifyListeners();
    }
  }

  void decreaseTextSize() {
    if (textSize > minTextSize) {
      textSize--;
      notifyListeners();
    }
  }
}
