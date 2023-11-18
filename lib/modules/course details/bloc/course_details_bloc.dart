// ignore_for_file: use_build_context_synchronously

import 'package:ateba_app/core/base/enums/tab_state.dart';
import 'package:ateba_app/core/network/api_response_model.dart';
import 'package:ateba_app/core/network/pagination_response_model.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/cart/bloc/cart_bloc.dart';
import 'package:ateba_app/modules/cart/data/models/orders_response.dart';
import 'package:ateba_app/modules/course%20details/data/models/course_details.dart';
import 'package:ateba_app/modules/course%20details/data/remote/course_details_remote_provider.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/comment.dart';
import 'package:flutter/material.dart';

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
  bool sendReplyLoading = false;
  bool repliesLoading = false;
  bool orderLoading = false;

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

  bool _showOptions = false;
  bool get showOptions => _showOptions;
  set showOptions(val) {
    _showOptions = val;
    notifyListeners();
  }

  int? selectedCommentIndex;
  String? _selectedComment;
  String? get selectedComment => _selectedComment;
  set selectedComment(val) {
    _selectedComment = val;
    notifyListeners();
  }

  String? commentIdForShowReplies;
  List<Comment> replies = [];

  final TextEditingController commentController = TextEditingController();
  final TextEditingController replayController = TextEditingController();

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

  Future<void> sendComment(
    BuildContext context,
    String slug,
  ) async {
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
      }
      sendCommentLoading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      sendCommentLoading = false;
      notifyListeners();
    }
  }

  Future<void> likeComment(String id, int index,
      {bool likeReply = false}) async {
    try {
      bool response = await CourseDetailsRemoteProvider.likeComment(
        id,
      );
      if (response) {
        if (likeReply) {
          replies[index].is_liked = true;
          replies[index].likes_count = (replies[index].likes_count ?? 0) + 1;
        } else {
          comments[index].is_liked = true;
          comments[index].likes_count = (comments[index].likes_count ?? 0) + 1;
        }
      }
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> unlikeComment(String id, int index,
      {bool likeReply = false}) async {
    try {
      bool response = await CourseDetailsRemoteProvider.unlikeComment(
        id,
      );
      if (response) {
        if (likeReply) {
          replies[index].is_liked = false;
          replies[index].likes_count = (replies[index].likes_count ?? 0) - 1;
        } else {
          comments[index].is_liked = false;
          comments[index].likes_count = (comments[index].likes_count ?? 0) - 1;
        }
      }
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> deleteComment() async {
    try {
      bool response = await CourseDetailsRemoteProvider.deleteComment(
        _selectedComment.toString(),
      );
      if (response) {
        comments.removeAt(selectedCommentIndex!);
        _selectedComment = null;
        showOptions = false;
        selectedCommentIndex = null;
        notifyListeners();
      }
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> loadReplies(String id) async {
    commentIdForShowReplies = id;
    repliesLoading = true;
    notifyListeners();
    try {
      ApiResponseModel<List<Comment>>? response =
          await CourseDetailsRemoteProvider.getReplies(
        id,
      );
      if (response != null) {
        replies = response.data ?? [];
      }
      repliesLoading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> sendReply(
      BuildContext context, String slug, String replyTo, int commentIndex,
      {bool replyToReply = false}) async {
    sendReplyLoading = true;
    notifyListeners();
    try {
      ApiResponseModel<Comment>? response =
          await CourseDetailsRemoteProvider.sendComment(
        slug,
        comment,
        replyTo: replyTo,
      );
      if (response != null && response.data != null) {
        if (replyToReply) {
          replies.add(response.data ?? Comment());
          commentController.clear();
          comment = '';
          int tempIndex =
              comments.indexWhere((e) => e.id == commentIdForShowReplies);
          if (tempIndex != -1) {
            comments[tempIndex].replies_count =
                (comments[tempIndex].replies_count ?? 0) + 1;
          }
          Navigator.of(context).pop();
        } else {
          comments[commentIndex].replies_count =
              (comments[commentIndex].replies_count ?? 0) + 1;
          commentController.clear();
          comment = '';
          Navigator.of(context).pop();
          await loadReplies(
            replyTo,
          );
        }
      }
      sendReplyLoading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      sendReplyLoading = false;
      notifyListeners();
    }
  }

  Future<void> orderCourse(String slug) async {
    orderLoading = true;
    notifyListeners();
    try {
      ApiResponseModel<OrdersResponse>? response =
          await CourseDetailsRemoteProvider.orderCourse(slug);
      if (response != null) {
        CartBloc().ordersResponse = response.data;
      }
      orderLoading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      orderLoading = false;
      notifyListeners();
    }
  }

  void hideReplies() {
    try {
      commentIdForShowReplies = null;
      replies.clear();
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }
}
