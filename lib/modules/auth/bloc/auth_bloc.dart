// ignore_for_file: use_build_context_synchronously

import 'package:ateba_app/core/base/base_box.dart';
import 'package:ateba_app/core/components/toast_component.dart';
import 'package:ateba_app/core/network/api_response_model.dart';
import 'package:ateba_app/core/network/network_helper.dart';
import 'package:ateba_app/core/router/routes.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/auth/data/models/token_response.dart';
import 'package:ateba_app/modules/auth/data/models/user.dart';
import 'package:ateba_app/modules/auth/data/remote/auth_remote_provider.dart';
import 'package:ateba_app/modules/cart/bloc/cart_bloc.dart';
import 'package:ateba_app/modules/categories/bloc/categories_bloc.dart';
import 'package:ateba_app/modules/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shamsi_date/shamsi_date.dart';

class AuthBloc extends ChangeNotifier {
  factory AuthBloc() => _instance;
  AuthBloc._init();
  static final AuthBloc _instance = AuthBloc._init();

  final BaseBox<String> _authBox = BaseBox('ateba-auth-box');

  String? _token;
  String? get token => _token;

  bool _isLogin = false;
  bool get isLogin => _isLogin;

  bool loading = false;
  bool loadingProfile = false;

  User? userProfile;
  Jalali? subscriptionExpireDate;

  String phone = '';

  Future<void> loadData() async {
    await Future.wait([
      loadProfileConfig(),
      loadProfile(),
      loadUserSubscription(),
    ]);
  }

  Future<void> init() async {
    try {
      await _authBox.open();
      NetworkHelper networkHelper = NetworkHelper();
      if (_authBox.isNotEmpty) {
        _token = await _authBox['main'];
        _isLogin = true;
        await networkHelper.initDio().then((_) {
          return loadProfile();
        });
      } else {
        await networkHelper.initDio();
      }
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<bool> sendCode(String phone) async {
    loading = true;
    this.phone = phone;
    notifyListeners();
    try {
      ApiResponseModel<bool> response = await AuthRemoteProvider.sendCode(
        '0098$phone',
      );
      showMessageToast(
        response.message,
        response.success ?? false,
      );
      loading = false;
      notifyListeners();
      return response.data ?? false;
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      loading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> verifyCode(BuildContext context, String code) async {
    loading = true;
    notifyListeners();
    try {
      ApiResponseModel<TokenResponse?> response =
          await AuthRemoteProvider.verifyCode('0098$phone', code);
      showMessageToast(
        response.message,
        response.success ?? false,
      );
      if (response.success ?? false) {
        if (response.data?.has_completed_profile ?? false) {
          _token = response.data?.token ?? '';
          _isLogin = true;
          authenticateUser(_token ?? '');
          await loadProfile();
          loading = false;
          notifyListeners();
          AuthBloc().loadData();
          Provider.of<HomeBloc>(context, listen: false).loadData();
          CategoriesBloc().loadCategories();
          CartBloc().loadOrders();
          context.goNamed(
            Routes.main,
          );
        } else {
          await loadProfileConfig();
          context.goNamed(
            Routes.completeInfo,
          );
        }
      }
      loading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      loading = false;
      notifyListeners();
    }
  }

  Future<void> loadProfile() async {
    loadingProfile = true;
    notifyListeners();
    try {
      ApiResponseModel<User?> response = await AuthRemoteProvider.getProfile();
      showMessageToast(
        response.message,
        response.success ?? false,
      );
      if (response.success ?? false) {
        userProfile = response.data;
      }
      loadingProfile = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      loadingProfile = false;
      notifyListeners();
    }
  }

  Future<void> loadProfileConfig() async {
    try {
      AuthRemoteProvider.getProfileConfig();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> loadAppConfig() async {
    try {
      //  AuthRemoteProvider.getAppConfig();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  void authenticateUser(String token) {
    try {
      _authBox.clear();
      _authBox['main'] = token;
      NetworkHelper networkHelper = NetworkHelper();
      networkHelper.initDio();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  void clearAuthBox() {
    try {
      _authBox.clear();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> loadUserSubscription() async {
    try {
      ApiResponseModel<String?> response =
          await AuthRemoteProvider.getUserSubscription();
      showMessageToast(
        response.message,
        response.success ?? false,
      );
      if (response.success ?? false) {
        int year =
            int.parse(response.data!.substring(0, response.data?.indexOf('-')));
        int month = int.parse(response.data?.substring(
                (response.data?.indexOf('-') ?? 0) + 1,
                response.data?.lastIndexOf('-')) ??
            '');
        int day = int.parse(response.data?.substring(
                ((response.data?.lastIndexOf('-') ?? 0) + 1),
                ((response.data?.lastIndexOf('-') ?? 0) + 3)) ??
            '');
        subscriptionExpireDate = Jalali.fromGregorian(
          Gregorian(
            year,
            month,
            day,
          ),
        );
      }
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  void showMessageToast(String? message, bool success) {
    if (message?.isNotEmpty ?? false) {
      ToastComponent.show(
        message,
        type: success ? ToastType.success : ToastType.error,
      );
    }
  }

  void logout() {
    _authBox.clear();
    userProfile = null;
    _isLogin = false;
    _token = null;
    phone = '';
    subscriptionExpireDate = null;
    loading = false;
    loadingProfile = false;
  }
}
