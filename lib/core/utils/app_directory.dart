import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<Directory> appDirectory() async {
  var appDir = await getApplicationDocumentsDirectory();
  return Directory('${appDir.path}/ccache').create(recursive: true);
}
