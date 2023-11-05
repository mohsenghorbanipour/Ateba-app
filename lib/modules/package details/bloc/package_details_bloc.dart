// ignore_for_file: use_build_context_synchronously

import 'package:ateba_app/core/base/enums/tab_state.dart';
import 'package:ateba_app/core/network/api_response_model.dart';
import 'package:ateba_app/core/network/pagination_response_model.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/cart/bloc/cart_bloc.dart';
import 'package:ateba_app/modules/cart/data/models/orders_response.dart';
import 'package:ateba_app/modules/package%20details/data/models/package_details.dart';
import 'package:ateba_app/modules/package%20details/data/remote/package_details_remote_provider.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/comment.dart';
import 'package:flutter/material.dart';

class PackageDetailsBloc extends ChangeNotifier {
  PackageDetailsBloc(String slug) {
    loadPackageDetials(slug);
    loadPackageComment(slug);
  }

  TabState _tabState = TabState.lessons;
  TabState get tabState => _tabState;
  set tabState(val) {
    _tabState = val;
    notifyListeners();
  }

  bool loading = false;
  bool commentLoading = true;
  bool sendCommentLoading = false;
  bool sendReplyLoading = false;
  bool orderLoading = false;

  PackageDetails? packageDetails;

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
  final TextEditingController replyController = TextEditingController();

  Future<void> loadPackageDetials(String slug) async {
    loading = true;
    notifyListeners();
    try {
      ApiResponseModel<PackageDetails>? response =
          await PackageDetailsRemoteProvider.getPackageDetials(
        slug,
      );
      if (response != null) {
        packageDetails = response.data;
      }
      loading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> loadPackageComment(slug) async {
    try {
      PaginationResponseModel<List<Comment>>? response =
          await PackageDetailsRemoteProvider.getPackageComment(slug);
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
          await PackageDetailsRemoteProvider.sendComment(
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

  Future<void> likeComment(String id, int index) async {
    try {
      bool response = await PackageDetailsRemoteProvider.likeComment(
        id,
      );
      if (response) {
        comments[index].is_liked = true;
        comments[index].likes_count = (comments[index].likes_count ?? 0) + 1;
        notifyListeners();
      }
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> unlikeComment(String id, int index) async {
    try {
      bool response = await PackageDetailsRemoteProvider.unlikeComment(
        id,
      );
      if (response) {
        comments[index].is_liked = false;
        comments[index].likes_count = (comments[index].likes_count ?? 0) - 1;
        notifyListeners();
      }
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> deleteComment() async {
    try {
      bool response = await PackageDetailsRemoteProvider.deleteComment(
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
    notifyListeners();
    try {
      ApiResponseModel<List<Comment>>? response =
          await PackageDetailsRemoteProvider.getReplies(
        id,
      );
      if (response != null) {
        replies = response.data ?? [];
      }
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> sendReply(BuildContext context, String slug, String replyTo,
      int commentIndex) async {
    sendReplyLoading = true;
    notifyListeners();
    try {
      ApiResponseModel<Comment>? response =
          await PackageDetailsRemoteProvider.sendComment(
        slug,
        comment,
        replyTo: replyTo,
      );
      if (response != null && response.data != null) {
        comments[commentIndex].replies_count =
            (comments[commentIndex].replies_count ?? 0) + 1;
        commentController.clear();
        comment = '';
        Navigator.of(context).pop();
        await loadReplies(
          replyTo,
        );
      }
      sendReplyLoading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      sendReplyLoading = false;
      notifyListeners();
    }
  }

  Future<void> bookmarkTutorial(String slug, int tutorialIndex) async {
    try {
      bool response = await PackageDetailsRemoteProvider.bookmarkTutorial(
        slug,
      );
      if (response) {
        packageDetails?.tutorials?[tutorialIndex].is_bookmarked = true;
        notifyListeners();
      }
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> unBookmarkTutorial(String slug, int tutorialIndex) async {
    try {
      bool? response = await PackageDetailsRemoteProvider.unBookmarkTutorial(
        slug,
      );
      if (response) {
        packageDetails?.tutorials?[tutorialIndex].is_bookmarked = false;
        notifyListeners();
      }
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> orderPackage(String slug) async {
    orderLoading = true;
    notifyListeners();
    try {
      ApiResponseModel<OrdersResponse>? response =
          await PackageDetailsRemoteProvider.orderPackage(slug);
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
