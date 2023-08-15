import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/home/data/models/banner_slider.dart';
import 'package:ateba_app/modules/home/data/models/course.dart';
import 'package:ateba_app/modules/home/data/models/package.dart';
import 'package:ateba_app/modules/home/data/remote/home_remote_provider.dart';
import 'package:flutter/foundation.dart';

class HomeBloc extends ChangeNotifier {
  List<BannerSlider> sliders = [];
  List<Package> packages = [];
  List<Package> popularStations = [];
  List<Course> courses = [];
  BannerSlider? bottomBanner;

  bool packagesLoading = false;

  Future<void> loadDate() async {
    await Future.wait([
      loadBannerSlider(),
      loadPackages(),
      loadCourses(),
      loadBottomBanner(),
      loadPopularStations(),
    ]);
  }

  Future<void> loadBannerSlider() async {
    try {
      sliders = await HomeRemoteProvider.getBannerSlider() ?? [];
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> loadPackages() async {
    try {
      packages = await HomeRemoteProvider.getPackages() ?? [];
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> loadCourses() async {
    try {
      courses = await HomeRemoteProvider.getCourses() ?? [];
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> loadBottomBanner() async {
    try {
      bottomBanner = await HomeRemoteProvider.getBanner();
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> loadPopularStations() async {
    try {
      await HomeRemoteProvider.getPopularStations();
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }
}
