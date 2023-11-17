import 'package:ateba_app/core/network/api_response_model.dart';
import 'package:ateba_app/core/network/pagination_response_model.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/bookmarks/data/models/bookmark.dart';
import 'package:ateba_app/modules/bookmarks/data/remote/bookmarks_remote_provider.dart';
import 'package:flutter/foundation.dart';

enum BookmarksStates {
  my_products,
  bookmarks,
  ofline_gallery,
}

enum BookmarkSortType {
  all,
  courses,
  packages,
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

  BookmarkSortType _bookmarkSortType = BookmarkSortType.all;
  BookmarkSortType get bookmarkSortType => _bookmarkSortType;
  set bookmarkSortType(val) {
    _bookmarkSortType = val;
    notifyListeners();
  }

  bool loading = false;
  bool loadingMore = false;

  List<Bookmark> dataList = [];

  bool? canLoadMoreBookmarks = false;
  int? bookmarksCurrentPage;

  Future<void> loadBookamrks() async {
    loading = true;
    notifyListeners();
    try {
      PaginationResponseModel<List<Bookmark>>? response =
          await BookmarksRemoteProvider.getBookmarks();
      if (response != null) {
        dataList = response.data ?? [];
        bookmarksCurrentPage = response.meta?.current_page ?? 0;
        canLoadMoreBookmarks = response.links?.next?.isNotEmpty ?? false;
      }
      loading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> loadMoreBookmarks() async {
    loadingMore = true;
    notifyListeners();
    try {
      PaginationResponseModel<List<Bookmark>>? response =
          await BookmarksRemoteProvider.getBookmarks(
        page: (bookmarksCurrentPage ?? 0) + 1,
      );
      if (response != null) {
        dataList.addAll(response.data ?? []);
        bookmarksCurrentPage = response.meta?.current_page ?? 0;
        canLoadMoreBookmarks = response.links?.next?.isNotEmpty ?? false;
      }
      loadingMore = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> loadMyProduct({required String type}) async {
    loading = true;
    notifyListeners();
    try {
      ApiResponseModel<List<Bookmark>>? response =
          await BookmarksRemoteProvider.getMyProducts(type);
      if (response != null) {
        dataList = response.data ?? [];
      }
      loading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> unbookmarkIc(String slug, int index) async {
    try {
      bool response = await BookmarksRemoteProvider.unBookmarkTutorial(slug);
      if (response) {
        dataList.removeAt(index);
        notifyListeners();
      }
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  void clearData() {
    dataList.clear();
    _bookmarkSortType = BookmarkSortType.all;
    _bookmarksStates = BookmarksStates.my_products;
    _showBookmarksState = false;
    loading = false;
    loadingMore = false;
    canLoadMoreBookmarks = false;
    bookmarksCurrentPage = null;
  }
}
