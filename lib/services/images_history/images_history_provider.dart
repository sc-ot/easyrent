import 'dart:convert';

import 'package:devtools/storage.dart';
import 'package:easyrent/core/constants.dart';
import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/models/image_history.dart';

class ImagesHistoryProvider extends StateProvider {
  Storage storage = Storage();

  ImagesHistoryProvider() {
    loadImages();
  }

  List<ImageHistory> imageHistory = [];

  void loadImages() {
    String? result = Storage.readString(Constants.KEY_IMAGES);
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
