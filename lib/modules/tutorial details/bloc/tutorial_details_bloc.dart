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
  List<Comment> comments = [];

  bool isLoadingMoreComments = false;
  bool canLoadMoreComment = false;
  int currentPageComments = 1;

  bool _showOptions = false;
  bool get showOptions => _showOptions;
  set showOptions(val) {
    _showOptions = val;
    notifyListeners();
  }

  int? selectedCommentIndex;
  int? _selectedComment;
  int? get selectedComment => _selectedComment;
  set selectedComment(val) {
    _selectedComment = val;
    notifyListeners();
  }

  int? commentIdForShowReplies;
  List<Comment> replies = [];

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
        comments = response.data ?? [];
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
      if (response) {
        tutorialDetaials?.is_liked = true;
        tutorialDetaials?.likes_count =
            (tutorialDetaials?.likes_count ?? 0) + 1;
        notifyListeners();
      }
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> unlikeTutorial(String slug) async {
    try {
      bool? response = await TutorialDetaialsRemoteProvider.unlikeTutorial(
        slug,
      );
      if (response) {
        tutorialDetaials?.is_liked = false;
        tutorialDetaials?.likes_count =
            (tutorialDetaials?.likes_count ?? 0) - 1;
        notifyListeners();
      }
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> bookmarkTutorial(String slug) async {
    try {
      bool response = await TutorialDetaialsRemoteProvider.bookmarkTutorial(
        slug,
      );
      if (response) {
        tutorialDetaials?.is_bookmarked = true;
        notifyListeners();
      }
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> unBookmarkTutorial(String slug) async {
    try {
      bool? response = await TutorialDetaialsRemoteProvider.unBookmarkTutorial(
        slug,
      );
      if (response) {
        tutorialDetaials?.is_bookmarked = false;
        notifyListeners();
      }
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> likeComment(String id, int index) async {
    try {
      bool response = await TutorialDetaialsRemoteProvider.likeComment(
        id,
      );
      if (response) {
        comments?[index].is_liked = true;
        comments?[index].likes_count = (comments?[index].likes_count ?? 0) + 1;
        notifyListeners();
      }
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> unlikeComment(String id, int index) async {
    try {
      bool? response = await TutorialDetaialsRemoteProvider.unlikeComment(
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

  Future<void> sendComment() async {
    try {
      // await TutorialDetaialsRemoteProvider.sendComment(
      //   // slug,
      // );
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> deleteComment() async {
    try {
      bool response = await TutorialDetaialsRemoteProvider.deleteComment(
        _selectedComment.toString(),
      );
      if (response) {
        comments.removeAt(selectedCommentIndex!);
        _selectedComment = null;
        selectedCommentIndex = null;
        notifyListeners();
      }
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> loadReplies(int id) async {
    commentIdForShowReplies = id;
    notifyListeners();
    try {
      ApiResponseModel<List<Comment>>? response =
          await TutorialDetaialsRemoteProvider.getReplies(
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
}
