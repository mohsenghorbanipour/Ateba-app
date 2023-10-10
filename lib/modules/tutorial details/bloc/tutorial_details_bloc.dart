import 'package:ateba_app/core/network/api_response_model.dart';
import 'package:ateba_app/core/network/pagination_response_model.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/comment.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/tutorial_details.dart';
import 'package:ateba_app/modules/tutorial%20details/data/remote/tutorial_details_remote_provider.dart';
import 'package:flutter/foundation.dart';

class TutorialDetaialsBloc extends ChangeNotifier {
  TutorialDetaialsBloc(String slug) {
    loadToturialDetials(slug);
    loadTuturialComments(slug);
  }

  bool loading = true;
  bool commentLoading = true;

  TutorialDetaials? tutorialDetaials;
  List<Comment>? comments = [];

  bool isLoadingMoreComments = false;
  bool canLoadMoreComment = false;
  int currentPageComments = 1;

  Future<void> loadToturialDetials(String slug) async {
    loading = true;
    notifyListeners();
    try {
      ApiResponseModel<TutorialDetaials>? response =
          await TutorialDetaialsRemoteProvider.getToturialDetials(slug);
      if (response != null) {
        tutorialDetaials = response.data;
      }
      loading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> loadTuturialComments(String slug) async {
    commentLoading = true;
    notifyListeners();
    try {
      PaginationResponseModel<List<Comment>>? response =
          await TutorialDetaialsRemoteProvider.getTutorialComments(slug);
      if (response != null) {
        comments = response.data;
        currentPageComments = 1;
        if (response.links?.next?.isNotEmpty ?? false) {
          canLoadMoreComment = true;
        } else {
          canLoadMoreComment = false;
        }
      }
      commentLoading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> loadMoreComments(String slug) async {
    isLoadingMoreComments = true;
    notifyListeners();
    try {
      PaginationResponseModel<List<Comment>>? response =
          await TutorialDetaialsRemoteProvider.getTutorialComments(
        slug,
        page: (currentPageComments + 1),
      );
      if (response != null) {
        comments?.addAll(response.data ?? []);
        currentPageComments++;
        if (response.links?.next?.isNotEmpty ?? false) {
          canLoadMoreComment = true;
        } else {
          canLoadMoreComment = false;
        }
      }
      isLoadingMoreComments = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> likeTutorial(String slug) async {
    try {
      bool response = await TutorialDetaialsRemoteProvider.likeTutorial(
        slug,
      );
      tutorialDetaials?.is_liked = response;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }
}
