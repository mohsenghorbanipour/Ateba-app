import 'package:ateba_app/core/network/pagination_response_model.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/search/data/models/filter.dart';
import 'package:ateba_app/modules/search/data/models/search_result.dart';
import 'package:ateba_app/modules/search/data/remote/search_remote_provider.dart';
import 'package:flutter/material.dart';

class SearchBloc extends ChangeNotifier {
  bool loading = false;
  bool loadingMore = false;
  bool canLoadMore = false;
  int? currentPage;

  TextEditingController controller = TextEditingController();
  String _query = '';
  String get query => _query;
  set query(val) {
    _query = val;
    notifyListeners();
  }

  List<Filter> filters = [];
  List<SearchResult> results = [];

  Filter? _selectedFilter;
  Filter? get selectedFilter => _selectedFilter;
  set selectedFilter(val) {
    if (_selectedFilter != val) {
      _selectedFilter = val;
      search();
      notifyListeners();
    }
  }

  Future<void> search() async {
    loading = true;
    notifyListeners();
    try {
      PaginationResponseModel<List<SearchResult>>? response =
          await SearchRemotePeovider.search(
        query,
        _selectedFilter?.key ?? '',
        _selectedFilter?.value ?? '',
      );
      if (response != null) {
        filters = response.filters ?? [];
        results = response.data ?? [];
        currentPage = response.meta?.current_page;
        canLoadMore = response.links?.next?.isNotEmpty ?? false;
        if (_selectedFilter?.value?.isEmpty ?? true) {
          _selectedFilter = filters.firstWhere((e) => e.value?.isEmpty ?? true);
        } else {
          _selectedFilter = filters
              .firstWhere((e) => e.value == (_selectedFilter?.value ?? ''));
        }
      }
      loading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      loading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreSearch() async {
    loadingMore = true;
    notifyListeners();
    try {
      PaginationResponseModel<List<SearchResult>>? response =
          await SearchRemotePeovider.search(
        query,
        _selectedFilter?.key ?? '',
        _selectedFilter?.value ?? '',
        page: (currentPage ?? 0) + 1,
      );
      if (response != null) {
        results.addAll(response.data ?? []);
        currentPage = response.meta?.current_page;
        canLoadMore = response.links?.next?.isNotEmpty ?? false;
      }
      loadingMore = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      loadingMore = false;
      notifyListeners();
    }
  }
}
