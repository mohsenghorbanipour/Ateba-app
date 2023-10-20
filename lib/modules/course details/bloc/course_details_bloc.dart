// ignore_for_file: use_build_context_synchronously

import 'package:ateba_app/core/network/api_response_model.dart';
import 'package:ateba_app/core/network/pagination_response_model.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/course%20details/data/models/course_details.dart';
import 'package:ateba_app/modules/course%20details/data/remote/course_details_remote_provider.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/comment.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum TabState {
  lessons,
  descriptions,
  teachers,
  comments,
}

class CourseDetailsBloc extends ChangeNotifier {
  CourseDetailsBloc(String slug) {
    loadCourseDetials(slug);
    loadCourseComment(slug);
  }

  TabState _tabState = TabState.lessons;
  TabState get tabState => _tabState;
  set tabState(val) {
    _tabState = val;
    notifyListeners();
  }

  bool loading = true;
  bool commentLoading = true;
  bool sendCommentLoading = false;

  CourseDetails? courseDetails;

  List<Comment> comments = [];
  int? currentCommentPage;
  bool canLoadMore = false;

  String _comment = '';
  String get comment => _comment;
  set comment(val) {
    _comment = val;
    notifyListeners();
  }

  final TextEditingController commentController = TextEditingController();

  Future<void> loadCourseDetials(String slug) async {
    try {
      ApiResponseModel<CourseDetails>? response =
          await CourseDetailsRemoteProvider.getCourseDetails(slug);
      if (response?.data != null) {
        courseDetails = response?.data;
      }
      loading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> loadCourseComment(slug) async {
    try {
      PaginationResponseModel<List<Comment>>? response =
          await CourseDetailsRemoteProvider.getCourseComment(slug);
      if (response != null) {
        comments = response.data ?? [];
        currentCommentPage = response.meta?.current_page ?? 1;
        canLoadMore = response.links?.next?.isNotEmpty ?? false;
      }
      commentLoading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> sendComment(BuildContext context, String slug) async {
    sendCommentLoading = true;
    notifyListeners();
    try {
      ApiResponseModel<Comment>? response =
          await CourseDetailsRemoteProvider.sendComment(
        slug,
        comment,
      );
      if (response != null && response.data != null) {
        comments.insert(0, response.data!);
        commentController.clear();
        comment = '';
        Navigator.of(context).pop();
      }
      sendCommentLoading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      sendCommentLoading = false;
      notifyListeners();
    }
  }

  
}
