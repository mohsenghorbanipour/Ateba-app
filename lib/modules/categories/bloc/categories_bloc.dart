import 'package:ateba_app/core/network/api_response_model.dart';
import 'package:ateba_app/core/network/pagination_response_model.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/categories/data/models/category.dart';
import 'package:ateba_app/modules/categories/data/remote/categories_remote_provider.dart';
import 'package:ateba_app/modules/home/data/models/course.dart';
import 'package:ateba_app/modules/home/data/models/package.dart';
import 'package:ateba_app/modules/home/data/models/tutorial.dart';
import 'package:flutter/material.dart';

enum TabState {
  educationalVideos,
  clinicalPackages,
}

enum CategoriesDataType {
  medicalCourses,
  educationalPackages,
}

class CategoriesBloc extends ChangeNotifier {
  factory CategoriesBloc() => _instance;
  CategoriesBloc._init();
  static final CategoriesBloc _instance = CategoriesBloc._init();

  // ==== Variables ==== //

  TabState _tabState = TabState.educationalVideos;
  TabState get tabState => _tabState;
  set tabState(val) {
    _tabState = val;
    notifyListeners();
  }

  CategoriesDataType _categoriesDataType = CategoriesDataType.medicalCourses;
  CategoriesDataType get categoriesDataType => _categoriesDataType;
  set categoriesDataType(val) {
    if (_categoriesDataType != val) {
      _categoriesDataType = val;
      notifyListeners();
      loadCategoryData();
    }
  }

  bool _showDataTypeMenu = false;
  bool get showDataTypeMenu => _showDataTypeMenu;
  set showDataTypeMenu(val) {
    _showDataTypeMenu = val;
    notifyListeners();
  }

  bool loading = false;
  bool loadingMore = false;

  List<Category> categories = [];

  int? currentPage;
  bool canLoadMore = true;

  List<Course> courses = [];
  List<Package> packages = [];

  // ==== ==== //

  Future<void> loadCategories() async {
    loading = true;
    notifyListeners();
    try {
      ApiResponseModel<List<Category>>? response =
          await CategoriesRemoteProvider.getCategories();
      if (response != null) {
        categories = response.data ?? [];
      }
      loading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  void loadCategoryData() {
    if (_categoriesDataType == CategoriesDataType.medicalCourses) {
      loadCourses();
    } else {
      loadPackages();
    }
  }

  void loadMoreCategoryData() {
    if (_categoriesDataType == CategoriesDataType.medicalCourses) {
      loadMoreCourses();
    } else {
      loadMorePackages();
    }
  }

  Future<void> loadCourses() async {
    loading = true;
    notifyListeners();
    try {
      PaginationResponseModel<List<Course>>? response =
          await CategoriesRemoteProvider.getCourses();
      if (response != null) {
        courses = response.data ?? [];
        currentPage = response.meta?.current_page;
        canLoadMore = response.links?.next?.isNotEmpty ?? false;
      }
      loading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> loadMoreCourses() async {
    loadingMore = true;
    notifyListeners();
    try {
      PaginationResponseModel<List<Course>>? response =
          await CategoriesRemoteProvider.getCourses(
        page: (currentPage! + 1),
      );
      if (response != null) {
        courses.addAll(response.data ?? []);
        currentPage = response.meta?.current_page;
        canLoadMore = response.links?.next?.isNotEmpty ?? false;
      }
      loadingMore = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> loadPackages() async {
    loading = true;
    notifyListeners();
    try {
      PaginationResponseModel<List<Package>>? response =
          await CategoriesRemoteProvider.getPackages();
      if (response != null) {
        packages = response.data ?? [];
        currentPage = response.meta?.current_page;
        canLoadMore = response.links?.next?.isNotEmpty ?? false;
      }
      loading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> loadMorePackages() async {
    try {
      loadingMore = true;
      notifyListeners();
      try {
        PaginationResponseModel<List<Package>>? response =
            await CategoriesRemoteProvider.getPackages(
          page: (currentPage! + 1),
        );
        if (response != null) {
          packages.addAll(response.data ?? []);
          currentPage = response.meta?.current_page;
          canLoadMore = response.links?.next?.isNotEmpty ?? false;
        }
        loadingMore = false;
        notifyListeners();
      } catch (e, s) {
        LoggerHelper.errorLog(e, s);
      }
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  void clearData() {
    courses.clear();
    packages.clear();
    categories.clear();
    _showDataTypeMenu = false;
    _tabState = TabState.educationalVideos;
    _categoriesDataType = CategoriesDataType.medicalCourses;
    _showDataTypeMenu = false;
    currentPage;
    canLoadMore = true;
    loading = false;
    loadingMore = false;
  }
}
