import 'package:flutter/foundation.dart';

enum BookmarksStates {
  my_products,
  bookmarks,
  ofline_gallery,
}

class BookmarksBloc extends ChangeNotifier {
  factory BookmarksBloc() => _instance;
  BookmarksBloc._init();
  static final BookmarksBloc _instance = BookmarksBloc._init();

  bool _showBookmarksState = false;
  bool get showBookmarksState => _showBookmarksState;
  set showBookmarksState(val) {
    _showBookmarksState = val;
    notifyListeners();
  }

  BookmarksStates _bookmarksStates = BookmarksStates.my_products;
  BookmarksStates get bookmarksStates => _bookmarksStates;
  set bookmarksStates(val) {
    _bookmarksStates = val;
    notifyListeners();
  }
}
