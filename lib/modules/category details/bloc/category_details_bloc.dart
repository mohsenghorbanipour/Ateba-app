import 'package:ateba_app/core/network/pagination_response_model.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/categories/data/models/category_details_response.dart';
import 'package:ateba_app/modules/category%20details/data/remote/category_details_remote_provider.dart';
import 'package:ateba_app/modules/home/data/models/tutorial.dart';
import 'package:flutter/foundation.dart';

class CategoryDetailsBloc extends ChangeNotifier {
  CategoryDetailsBloc(String slug) {
    loadCategoryDetails(slug);
  }

  bool loading = false;
  bool withSubCategory = false;
  bool canLoadMore = true;

  int? currentPageCategoryDetails;
  List<Tutorial> tutorials = [];
  List<CategoryDetailsResponse> categoryTutorials = [];

  Future<void> loadCategoryDetails(String slug) async {
    loading = true;
    notifyListeners();
    try {
      dynamic response = await CategoryDetailsRemoteProvider.getCategoryDetails(
        slug,
      );
      if (response != null) {
        if (response is PaginationResponseModel<List<Tutorial>>) {
          withSubCategory = false;
          tutorials = response.data ?? [];
          canLoadMore = response.links?.next?.isNotEmpty ?? false;
          currentPageCategoryDetails = response.meta?.current_page;
        } else if (response
            is PaginationResponseModel<List<CategoryDetailsResponse>>) {
          withSubCategory = true;
          categoryTutorials = response.data ?? [];
          canLoadMore = response.links?.next?.isNotEmpty ?? false;
          currentPageCategoryDetails = response.meta?.current_page;
        }
      }
      loading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }
}
