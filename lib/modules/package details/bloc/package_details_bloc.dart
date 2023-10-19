import 'package:ateba_app/core/network/api_response_model.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/package%20details/data/models/package_details.dart';
import 'package:ateba_app/modules/package%20details/data/remote/package_remote_provider.dart';
import 'package:flutter/foundation.dart';

class PackageDetailsBloc extends ChangeNotifier {
  PackageDetailsBloc(String slug) {
    loadPackageDetials(slug);
  }

  bool loading = false;
  PackageDetails? packageDetails;

  Future<void> loadPackageDetials(String slug) async {
    loading = true;
    notifyListeners();
    try {
      ApiResponseModel<PackageDetails>? response = await PackageRemoteProvider.getPackageDetials(
        slug,
      );
      if(response != null) {
        packageDetails = response.data;
      }
      loading = false;
      notifyListeners();
    } catch (e, s) {
      LoggerHelper.errorLog(e, s);
    }
  }
}
