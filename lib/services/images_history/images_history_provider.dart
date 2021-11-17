import 'dart:convert';

import 'package:easyrent/core/constants.dart';
import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/models/image_history.dart';
import 'package:sc_appframework/storage/sc_shared_prefs_storage.dart';

class ImagesHistoryProvider extends StateProvider {
  ImagesHistoryProvider() {
    loadImages();
  }

  List<ImageHistory> imageHistory = [];

  void loadImages() {
    String? result = SCSharedPrefStorage.readString(Constants.KEY_IMAGES);
    if (result != null) {
      var test = jsonDecode(result);
      for (var element in test) {
        imageHistory.add(
          ImageHistory.fromJson(element),
        );
      }
    }
  }
}
