import 'package:ateba_app/core/network/pagination_response_model.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/home/data/models/course.dart';
import 'package:ateba_app/modules/home/data/models/tutorial.dart';
import 'package:ateba_app/modules/home/data/remote/home_remote_provider.dart';
import 'package:flutter/foundation.dart';

class HomeBloc extends ChangeNotifier {
  // ==== Variables ==== //

  bool coursesLoading = true;
  int? coursesCurrentPage;
  List<Course> courses = [];

  bool toturialsLoading = false;
  List<Tutorial> tutorials = [];

  // ==== ==== //

  Future<void> loadDate() async {
    await Future.wait([
      loadToturials(),
      loadCourses(),
    ]);
  }

  Future<void> loadToturials() async {
    try {
      PaginationResponseModel<List<Tutorial>>? response =
          await HomeRemoteProvider.getToturials();
      if (response != null) {
        tutorials = response.data ?? [];
        coursesCurrentPage = response.meta?.current_page ?? 1;
      }
      toturialsLoading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> loadCourses() async {
    try {
      await HomeRemoteProvider.getCourses();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }
}
