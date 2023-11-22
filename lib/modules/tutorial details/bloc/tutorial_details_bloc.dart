// ignore_for_file: use_build_context_synchronously

import 'package:ateba_app/core/network/api_response_model.dart';
import 'package:ateba_app/core/network/pagination_response_model.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/comment.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/tutorial_details.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/video.dart';
import 'package:ateba_app/modules/tutorial%20details/data/remote/tutorial_details_remote_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

enum AttachmentType {
  text,
  gallery,
  video,
  voice,
  pdf,
  file,
  link,
}

class TutorialDetaialsBloc extends ChangeNotifier {
  TutorialDetaialsBloc(String slug) {
    loadToturialDetials(slug);
    loadTuturialComments(slug);
  }

  bool loading = true;
  bool commentLoading = true;
  bool sendCommentLoading = false;
  bool repliesLoading = false;
  bool bookmarkLoading = false;
  bool likeLoading = false;
  bool commentLikeLoading = false;

  TutorialDetaials? tutorialDetaials;
  List<Comment> comments = [];

  int? _selectedVideoIndex;
  int? get selectedVideoIndex => _selectedVideoIndex;
  set selectedVideoIndex(val) {
    _selectedVideoIndex = val;
    notifyListeners();
  }

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
  String? _selectedComment;
  String? get selectedComment => _selectedComment;
  set selectedComment(val) {
    _selectedComment = val;
    notifyListeners();
  }

  String? commentIdForShowReplies;
  List<Comment> replies = [];

  String _comment = '';
  String get comment => _comment;
  set comment(val) {
    _comment = val;
    notifyListeners();
  }

  final TextEditingController commentController = TextEditingController();

  final audioPlayer = AudioPlayer();

  String likedCommentId = '';

  Future<void> loadToturialDetials(String slug) async {
    loading = true;
    notifyListeners();
    try {
      ApiResponseModel<TutorialDetaials>? response =
          await TutorialDetaialsRemoteProvider.getToturialDetials(slug);
      if (response != null) {
        tutorialDetaials = response.data;
        if (tutorialDetaials?.videos is List<dynamic>) {
          selectedVideoIndex = 0;
        }
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
        comments.addAll(response.data ?? []);
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
    likeLoading = true;
    notifyListeners();
    try {
      bool response = await TutorialDetaialsRemoteProvider.likeTutorial(
        slug,
      );
      if (response) {
        tutorialDetaials?.is_liked = true;
        tutorialDetaials?.likes_count =
            (tutorialDetaials?.likes_count ?? 0) + 1;
      }
      likeLoading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      likeLoading = false;
      notifyListeners();
    }
  }

  Future<void> unlikeTutorial(String slug) async {
    likeLoading = true;
    notifyListeners();
    try {
      bool? response = await TutorialDetaialsRemoteProvider.unlikeTutorial(
        slug,
      );
      if (response) {
        tutorialDetaials?.is_liked = false;
        tutorialDetaials?.likes_count =
            (tutorialDetaials?.likes_count ?? 0) - 1;
      }
      likeLoading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      likeLoading = false;
      notifyListeners();
    }
  }

  Future<void> bookmarkTutorial(String slug) async {
    bookmarkLoading = true;
    notifyListeners();
    try {
      bool response = await TutorialDetaialsRemoteProvider.bookmarkTutorial(
        slug,
      );
      if (response) {
        tutorialDetaials?.is_bookmarked = true;
      }
      bookmarkLoading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      bookmarkLoading = false;
      notifyListeners();
    }
  }

  Future<void> unBookmarkTutorial(String slug) async {
    bookmarkLoading = true;
    notifyListeners();
    try {
      bool? response = await TutorialDetaialsRemoteProvider.unBookmarkTutorial(
        slug,
      );
      if (response) {
        tutorialDetaials?.is_bookmarked = false;
      }
      bookmarkLoading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      bookmarkLoading = false;
      notifyListeners();
    }
  }

  Future<void> likeComment(String id, int index,
      {bool likeReply = false}) async {
    commentLikeLoading = true;
    likedCommentId = id;
    notifyListeners();
    try {
      bool response = await TutorialDetaialsRemoteProvider.likeComment(
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
      commentLikeLoading = false;
      likedCommentId = '';
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      commentLikeLoading = false;
      likedCommentId = '';
      notifyListeners();
    }
  }

  Future<void> unlikeComment(String id, int index,
      {bool likeReply = false}) async {
    commentLikeLoading = true;
    likedCommentId = id;
    notifyListeners();
    try {
      bool? response = await TutorialDetaialsRemoteProvider.unlikeComment(
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
      commentLikeLoading = false;
      likedCommentId = '';
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      commentLikeLoading = false;
      likedCommentId = '';
      notifyListeners();
    }
  }

  Future<void> sendComment(BuildContext context, String slug) async {
    sendCommentLoading = true;
    notifyListeners();
    try {
      ApiResponseModel<Comment>? response =
          await TutorialDetaialsRemoteProvider.sendComment(
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

  Future<void> sendReply(
      BuildContext context, String slug, String replyTo, int commentIndex,
      {bool replyToReply = false}) async {
    sendCommentLoading = true;
    notifyListeners();
    try {
      ApiResponseModel<Comment>? response =
          await TutorialDetaialsRemoteProvider.sendComment(
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
      sendCommentLoading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      sendCommentLoading = false;
      notifyListeners();
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
        showOptions = false;
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
          await TutorialDetaialsRemoteProvider.getReplies(
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

  void hideReplies() {
    try {
      commentIdForShowReplies = null;
      replies.clear();
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Video? getVideo() {
    try {
      if (selectedVideoIndex != null && selectedVideoIndex != -1) {
        List<Video> videos = (tutorialDetaials?.videos as List<dynamic>)
            .map(
              (e) => Video.fromJson(e),
            )
            .toList();
        return videos[selectedVideoIndex!];
      }
      return null;
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      return null;
    }
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}
