// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:ateba_app/core/constants/image_compress.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/edit%20profile/data/remote/edit_profile_remote_provider.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileBloc extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  XFile? _pickedImage;

  Future<void> updataProfile() async {
    try {} catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

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
          _pickedImage = await compressAndGetFile(
            File(croppedFile.path),
            context,
          );
          FormData formData = FormData.fromMap(
            {
              'picture': await MultipartFile.fromFile(
                pickedFile.path,
              ),
            },
          );
          String? PathUrl = await uploadImage(formData);
        }
      }
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }

  Future<String?> uploadImage(FormData formData) async {
    try {
      EditProfileRemoteProvider.uploadImage(
        formData,
      );
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }
}
