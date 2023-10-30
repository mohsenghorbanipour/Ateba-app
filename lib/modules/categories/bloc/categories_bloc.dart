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
  educationalProducts,
  medicalCourses,
  educationalPackages,
}

class CategoriesBloc extends ChangeNotifier {
  // ==== Variables ==== //

  TabState _tabState = TabState.educationalVideos;
  TabState get tabState => _tabState;
  set tabState(val) {
    _tabState = val;
    notifyListeners();
  }

  CategoriesDataType _categoriesDataType =
      CategoriesDataType.educationalProducts;
  CategoriesDataType get categoriesDataType => _categoriesDataType;
  set categoriesDataType(val) {
    if (_categoriesDataType != val) {
      _categoriesDataType = val;
      notifyListeners();
    }
  }

  bool _showDataTypeMenu = false;
  bool get showDataTypeMenu => _showDataTypeMenu;
  set showDataTypeMenu(val) {
    _showDataTypeMenu = val;
    notifyListeners();
  }

  bool loading = false;

  List<Category> categories = [];

  int? currentPageTutorial;
  bool canLoadMoreTutorial = true;
  List<Tutorial> tutorials = [];

  int? currentPageCourse;
  bool canLoadMoreCourse = true;
  List<Course> courses = [];

  int? currentPagePackage;
  bool canLoadMorePackage = true;
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
    if (_categoriesDataType == CategoriesDataType.educationalProducts) {
      loadTutorials();
    } else if (_categoriesDataType == CategoriesDataType.medicalCourses) {
      loadCourses();
    } else {
      loadPackages();
    }
  }

  void loadMoreCategoryData() {
    if (_categoriesDataType == CategoriesDataType.educationalProducts) {
      loadMoreTutorial();
    } else if (_categoriesDataType == CategoriesDataType.medicalCourses) {
      loadMoreCourses();
    } else {
      loadMorePackages();
    }
  }

  Future<void> loadTutorials() async {
    loading = true;
    notifyListeners();
    try {
      PaginationResponseModel<List<Tutorial>>? response =
          await CategoriesRemoteProvider.getToturials();
      if (response != null) {
        tutorials = response.data ?? [];
        currentPageTutorial = response.meta?.current_page;
        canLoadMoreTutorial = response.links?.next?.isNotEmpty ?? false;
      }
      loading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> loadMoreTutorial() async {}

  Future<void> loadCourses() async {
    loading = true;
    notifyListeners();
    try {
      PaginationResponseModel<List<Course>>? response =
          await CategoriesRemoteProvider.getCourses();
      if (response != null) {
        courses = response.data ?? [];
        currentPageCourse = response.meta?.current_page;
        canLoadMoreCourse = response.links?.next?.isNotEmpty ?? false;
      }
      loading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> loadMoreCourses() async {
    try {} catch (e, s) {
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
        currentPagePackage = response.meta?.current_page;
        canLoadMorePackage = response.links?.next?.isNotEmpty ?? false;
      }
      loading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> loadMorePackages() async {
    try {} catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }
}
