// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:ateba_app/core/components/toast_component.dart';
import 'package:ateba_app/core/constants/image_compress.dart';
import 'package:ateba_app/core/network/api_response_model.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/auth/data/models/config_item.dart';
import 'package:ateba_app/modules/auth/data/models/profile_config_response.dart';
import 'package:ateba_app/modules/auth/data/models/user.dart';
import 'package:ateba_app/modules/auth/data/remote/auth_remote_provider.dart';
import 'package:ateba_app/modules/edit%20profile/data/remote/edit_profile_remote_provider.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

enum Gender {
  male,
  female,
}

class EditProfileBloc extends ChangeNotifier {
  // Variables

  bool loadingProfileConfig = false;
  bool loadingCities = false;

  String imagePath = '';

  bool _isEditedProfile = false;
  bool get isEditedProfile => _isEditedProfile;
  set isEditedProfile(val) {
    _isEditedProfile = val;
    notifyListeners();
  }

  Gender _gender = Gender.male;
  Gender get gender => _gender;
  set gender(val) {
    _gender = val;
    notifyListeners();
  }

  ProfileConfigResponse? profileConfigResponse;
  List<ConfigItem> cities = [];

  ConfigItem? _selectedFiled;
  ConfigItem? get selectedFiled => _selectedFiled;
  set selectedFiled(val) {
    if (_selectedFiled != val) {
      _selectedFiled = val;
      isEditedProfile = true;
      notifyListeners();
    }
  }

  ConfigItem? _selectedUniversity;
  ConfigItem? get selectedUniversity => _selectedUniversity;
  set selectedUniversity(val) {
    if (_selectedUniversity != val) {
      _selectedUniversity = val;
      isEditedProfile = true;
      notifyListeners();
    }
  }

  ConfigItem? _selectedProvince;
  ConfigItem? get selectedProvince => _selectedProvince;
  set selectedProvince(val) {
    if (_selectedProvince != val) {
      _selectedProvince = val;
      isEditedProfile = true;
      notifyListeners();
    }
  }

  ConfigItem? _selectedCity;
  ConfigItem? get selectedCity => _selectedCity;
  set selectedCity(val) {
    if (_selectedCity != val) {
      _selectedCity = val;
      isEditedProfile = true;
      notifyListeners();
    }
  }

  // ====== //

  static const int maxFileSize = 1024 * 1024;
  final ImagePicker _picker = ImagePicker();
  XFile? pickedImage;

  Future<void> pickAndCompressImage(BuildContext context) async {
    try {
      XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        final croppedFile = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          cropStyle: CropStyle.circle,
          maxHeight: 400,
          maxWidth: 400,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'crop_image'.tr(),
              toolbarColor: ColorPalette.light.primary,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: false,
              hideBottomControls: true,
            ),
            IOSUiSettings(
              title: 'crop_image'.tr(),
              hidesNavigationBar: true,
            ),
            WebUiSettings(
              context: context,
              presentStyle: CropperPresentStyle.page,
              boundary: const CroppieBoundary(
                width: 400,
                height: 400,
              ),
              viewPort: const CroppieViewPort(
                width: 400,
                height: 400,
              ),
              enableExif: true,
              enableZoom: true,
              showZoomer: true,
            ),
          ],
        );

        if (croppedFile != null) {
          pickedImage = await compressAndGetFile(
            File(croppedFile.path),
            context,
          );
          File file = File(pickedImage?.path ?? '');
          final FileStat fileStat = await file.stat();
          var decodedImage = await decodeImageFromList(file.readAsBytesSync());
          print(decodedImage.width);
          print(decodedImage.height);
          print(fileStat.size);
          if ((fileStat.size) <= maxFileSize) {
            FormData formData = FormData.fromMap(
              {
                'picture': await MultipartFile.fromFile(
                  pickedFile.path,
                ),
              },
            );
            await uploadImage(formData);
          } else {
            ToastComponent.show(
              'image_large_size'.tr(),
              type: ToastType.info,
            );
          }
        }
      }
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> uploadImage(FormData formData) async {
    try {
      ApiResponseModel<String?> response =
          await EditProfileRemoteProvider.uploadImage(
        formData,
      );
      showMessageToast(
        response.message ?? '',
        response.success ?? false,
      );
      if (response.success ?? false) {
        imagePath = response.data ?? '';
      } else {
        pickedImage = null;
      }
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<void> loadProfileConfig() async {
    loadingProfileConfig = true;
    notifyListeners();
    try {
      ApiResponseModel<ProfileConfigResponse>? response =
          await AuthRemoteProvider.getProfileConfig();
      showMessageToast(response?.message ?? '', response?.success ?? false);
      if (response?.success ?? false) {
        profileConfigResponse = response?.data;
      }
      loadingProfileConfig = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      loadingProfileConfig = false;
      notifyListeners();
    }
  }

  Future<void> loadCities() async {
    loadingCities = true;
    notifyListeners();
    try {
      ApiResponseModel<List<ConfigItem>?> response =
          await AuthRemoteProvider.getCities(_selectedProvince!.id!);
      showMessageToast(response.message ?? '', response.success ?? false);
      if (response.success ?? true) {
        cities = response.data ?? [];
      }
      loadingCities = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
      loadingCities = false;
      notifyListeners();
    }
  }

  Future<void> editProfile() async {
    try {
      EditProfileRemoteProvider.updataProfile(
        FormData.fromMap(
          {
            'field_id': _selectedFiled?.id,
            'university_id': _selectedUniversity?.id,
            'country': 'ایران',
            'province_id': _selectedProvince?.id,
            'city_id': _selectedCity?.id,
            'gender': gender.name,
          },
        ),
      );
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
}
