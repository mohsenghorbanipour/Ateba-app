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
      // ApiResponseModel<Comment>? response =
      //     await CourseDetailsRemoteProvider.sendComment(
      //   slug,
      //   comment,
      // );
      // if (response != null && response.data != null) {
      //   comments.insert(0, response.data!);
      //   commentController.clear();
      //   comment = '';
      //   Navigator.of(context).pop();
      // }
      // sendCommentLoading = false;
      // notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      // sendCommentLoading = false;
      // notifyListeners();
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
}
