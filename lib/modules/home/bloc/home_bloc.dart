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

  bool bannerSliderLoading = true;
  bool packagesLoading = true;
  bool coursesLoading = true;
  bool bottomBannerLoading = true;

  Future<void> loadDate() async {
    await Future.wait([
      loadBannerSlider(),
      loadPackages(),
      loadCourses(),
      loadBottomBanner(),
    ]);
  }

  Future<void> loadBannerSlider() async {
    try {
      sliders = await HomeRemoteProvider.getBannerSlider() ?? [];
      bannerSliderLoading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> loadPackages() async {
    try {
      packages = await HomeRemoteProvider.getPackages() ?? [];
      packagesLoading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> loadCourses() async {
    try {
      courses = await HomeRemoteProvider.getCourses() ?? [];
      coursesLoading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> loadBottomBanner() async {
    try {
      bottomBanner = await HomeRemoteProvider.getBanner();
      bottomBannerLoading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }
}
