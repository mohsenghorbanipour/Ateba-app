import 'package:ateba_app/core/components/toast_component.dart';
import 'package:ateba_app/core/network/api_response_model.dart';
import 'package:ateba_app/core/network/pagination_response_model.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/home/data/models/banner_slider.dart';
import 'package:ateba_app/modules/home/data/models/course.dart';
import 'package:ateba_app/modules/home/data/models/package.dart';
import 'package:ateba_app/modules/home/data/models/suggestions.dart';
import 'package:ateba_app/modules/home/data/models/tutorial.dart';
import 'package:ateba_app/modules/home/data/remote/home_remote_provider.dart';
import 'package:flutter/foundation.dart';

class HomeBloc extends ChangeNotifier {
  // ==== Variables ==== //

  bool coursesLoading = true;
  List<Course> courses = [];

  bool toturialsLoading = true;
  List<Tutorial> tutorials = [];

  bool topBannerLoading = true;
  List<BannerSlider> topBanners = [];

  bool middleBannerLoading = true;
  BannerSlider? middleBanners;

  bool packagesLoading = true;
  List<Package> packages = [];

  bool suggestionsLoading = true;
  Suggestions? suggestions;

  // ==== ==== //

  Future<void> loadData() async {
    await Future.wait([
      loadTopBanner(),
      loadToturials(),
      loadCourses(),
      loadMiddleBanner(),
      loadPackages(),
      loadSuggestions(),
    ]);
  }

  Future<void> loadTopBanner() async {
    topBannerLoading = true;
    notifyListeners();
    try {
      ApiResponseModel<List<BannerSlider>>? response =
          await HomeRemoteProvider.getTopBanner();
      if (response != null) {
        topBanners = response.data ?? [];
      }
      topBannerLoading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> loadSuggestions() async {
    suggestionsLoading = true;
    notifyListeners();
    try {
      ApiResponseModel<Suggestions?> response =
          await HomeRemoteProvider.getSuggestion();
      showMessageToast(response.message, response.success ?? false);
      if (response.success ?? false) {
        suggestions = response.data;
      }
      suggestionsLoading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      suggestionsLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadToturials() async {
    toturialsLoading = true;
    notifyListeners();
    try {
      PaginationResponseModel<List<Tutorial>>? response =
          await HomeRemoteProvider.getToturials();
      if (response != null) {
        tutorials = response.data ?? [];
      }
      toturialsLoading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> loadCourses() async {
    coursesLoading = true;
    notifyListeners();
    try {
      PaginationResponseModel<List<Course>>? response =
          await HomeRemoteProvider.getCourses();
      if (response != null) {
        courses = response.data ?? [];
      }
      coursesLoading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> loadMiddleBanner() async {
    middleBannerLoading = true;
    notifyListeners();
    try {
      ApiResponseModel<List<BannerSlider>>? response =
          await HomeRemoteProvider.getMiddleBanner();
      if (response != null) {
        middleBanners = response.data?.first;
      }
      middleBannerLoading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> loadPackages() async {
    packagesLoading = true;
    notifyListeners();
    try {
      PaginationResponseModel<List<Package>>? response =
          await HomeRemoteProvider.getPackages();
      if (response != null) {
        packages = response.data ?? [];
      }
      packagesLoading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  void showMessageToast(String? message, bool success) {
    if (message?.isNotEmpty ?? false) {
      ToastComponent.show(
        message,
        type: success ? ToastType.success : ToastType.error,
      );
    }
  }

  void clearData() {
    courses.clear();
    packages.clear();
    tutorials.clear();
    middleBanners = null;
    topBanners.clear();
    coursesLoading = true;
    toturialsLoading = true;
    topBannerLoading = true;
    middleBannerLoading = true;
    packagesLoading = true;
  }
}
