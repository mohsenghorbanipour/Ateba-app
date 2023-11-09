// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

Future<XFile?> compressAndGetFile(File file, BuildContext context) async {
  var imageSize = file.lengthSync() / 1024;
  int quality;
  if (imageSize <= 200) {
    quality = 100;
  } else if (imageSize <= 400) {
    quality = 90;
  } else if (imageSize <= 600) {
    quality = 80;
  } else if (imageSize <= 1000) {
    quality = 70;
  } else if (imageSize <= 2000) {
    quality = 60;
  } else if (imageSize <= 3000) {
    quality = 50;
  } else if (imageSize <= 4000) {
    quality = 40;
  } else {
    quality = 30;
  }

  final dir = await path_provider.getTemporaryDirectory();
  // ignore: unused_local_variable
  final targetPath = "${dir.absolute.path}/temp.jpg";
  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    '${file.absolute.path}-temp.jpg',
    quality: quality,
  );

  return result;
}

String getBigProfilePic(String imagePath) {
  File filePath = File(imagePath);
  String filaName = basename(filePath.path);
  String baseUrl = imagePath.split(filaName)[0];
  String bigProfilePic = '${baseUrl}big/$filaName';
  return bigProfilePic;
}
