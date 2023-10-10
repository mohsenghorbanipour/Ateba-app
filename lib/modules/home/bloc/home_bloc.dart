import 'package:ateba_app/core/network/api_response_model.dart';
import 'package:ateba_app/core/network/pagination_response_model.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/home/data/models/banner_slider.dart';
import 'package:ateba_app/modules/home/data/models/course.dart';
import 'package:ateba_app/modules/home/data/models/tutorial.dart';
import 'package:ateba_app/modules/home/data/remote/home_remote_provider.dart';
import 'package:flutter/foundation.dart';

class HomeBloc extends ChangeNotifier {
  // ==== Variables ==== //

  bool coursesLoading = true;
  List<Course> courses = [];

  bool toturialsLoading = false;
  List<Tutorial> tutorials = [];

  bool topBannerLoading = true;
  List<BannerSlider> topBanners = [];

  bool middleBannerLoading = true;
  BannerSlider? middleBanners;

  // ==== ==== //

  Future<void> loadDate() async {
    await Future.wait([
      loadTopBanner(),
      loadToturials(),
      loadCourses(),
      loadMiddleBanner(),
    ]);
  }

  Future<void> loadTopBanner() async {
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

  Future<void> loadToturials() async {
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
}
