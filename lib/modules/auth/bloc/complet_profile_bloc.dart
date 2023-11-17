// import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';

// class CompleteProfileBloc extends ChangeNotifier {

//   Future<void> pickAndCompressImage(BuildContext context) async {
//     try {
//       XFile? pickedFile = await _picker.pickImage(
//         source: ImageSource.gallery,
//       );

//       if (pickedFile != null) {
//         final croppedFile = await ImageCropper().cropImage(
//           sourcePath: pickedFile.path,
//           cropStyle: CropStyle.circle,
//           maxHeight: 400,
//           maxWidth: 400,
//           uiSettings: [
//             AndroidUiSettings(
//               toolbarTitle: 'crop_image'.tr(),
//               toolbarColor: ColorPalette.light.primary,
//               toolbarWidgetColor: Colors.white,
//               initAspectRatio: CropAspectRatioPreset.square,
//               lockAspectRatio: false,
//               hideBottomControls: true,
//             ),
//             IOSUiSettings(
//               title: 'crop_image'.tr(),
//               hidesNavigationBar: true,
//             ),
//             WebUiSettings(
//               context: context,
//               presentStyle: CropperPresentStyle.page,
//               boundary: const CroppieBoundary(
//                 width: 400,
//                 height: 400,
//               ),
//               viewPort: const CroppieViewPort(
//                 width: 400,
//                 height: 400,
//               ),
//               enableExif: true,
//               enableZoom: true,
//               showZoomer: true,
//             ),
//           ],
//         );

//         if (croppedFile != null) {
//           _pickedImage = await compressAndGetFile(
//             File(croppedFile.path),
//             context,
//           );
//           FormData formData = FormData.fromMap(
//             {
//               'picture': await MultipartFile.fromFile(
//                 pickedFile.path,
//               ),
//             },
//           );
//           String? PathUrl = await uploadImage(formData);
//         }
//       }
//     } catch (e, s) {
//       LoggerHelper.errorLog(e, s);
//     }
//   }

// }