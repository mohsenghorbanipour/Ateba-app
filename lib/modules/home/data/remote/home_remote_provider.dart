import 'dart:convert';

import 'package:ateba_app/core/constants/remote_routes.dart';
import 'package:ateba_app/core/network/network_helper.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/home/data/models/banner_slider.dart';
import 'package:ateba_app/modules/home/data/models/course.dart';
import 'package:ateba_app/modules/home/data/models/package.dart';
import 'package:dio/dio.dart';

class HomeRemoteProvider {
  static final NetworkHelper _networkHelper = NetworkHelper();

  static Future<List<BannerSlider>?> getBannerSlider() async {
    try {
      Response response =
          await _networkHelper.dio.get(RemoteRoutes.getBannerSlider);
      if (response.data != null) {
        final result = json.decode(response.data);
        return (result as List<dynamic>)
            .map<BannerSlider>(
                (i) => BannerSlider.fromJson(i as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      return [];
    }
  }

  static Future<List<Package>?> getPackages() async {
    try {
      Response response =
          await _networkHelper.dio.get(RemoteRoutes.getPackages);
      if (response.data != null) {
        final result = json.decode(response.data);
        return (result as List<dynamic>)
            .map<Package>((i) => Package.fromJson(i as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      return [];
    }
  }

  static Future<List<Course>?> getCourses() async {
    try {
      Response response = await _networkHelper.dio.get(RemoteRoutes.getCourses);
      if (response.data != null) {
        final result = json.decode(response.data);
        return (result as List<dynamic>)
            .map<Course>((i) => Course.fromJson(i as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      return [];
    }
  }

  static Future<BannerSlider?> getBanner() async {
    try {
      Response response =
          await _networkHelper.dio.get(RemoteRoutes.getBottomBanner);
      if (response.data != null) {
        final result = json.decode(response.data);
        return BannerSlider.fromJson(result);
      }
      return null;
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      return null;
    }
  }
}
