import 'dart:async';
import 'dart:io';

import 'package:easyrent/core/constants.dart';
import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/core/utils.dart';
import 'package:easyrent/network/repository.dart';
import 'package:easyrent/services/camera/camera_page.dart';
import 'package:watcher/watcher.dart';

class ImageCacheLogProvider extends StateProvider {
  String imagesPath = "";
  List<Map<String, dynamic>> keys = [];
  StreamSubscription? directoryWatcherSubscription;
  int uploadGroupId = 0;
  EasyRentRepository easyRentRepository = EasyRentRepository();

  ImageCacheLogProvider(this.uploadGroupId) {
    loadCacheImages();
  }

  void loadCacheImages() async {
    keys = [];

    setState(state: STATE.LOADING);
    imagesPath =
        await Utils.createFolderInAppDocDir("images") + "$uploadGroupId" + "/";
    Directory dir = Directory(imagesPath);
    List<FileSystemEntity> images = [];

    try {
      images = dir.listSync(recursive: true, followLinks: false);
    } catch (e) {
      print(e);
      setState(state: STATE.ERROR);
      return;
    }

    getImageDataFromFileNames(images);
    directoryWatcherSubscription?.cancel();

    directoryWatcherSubscription = DirectoryWatcher(imagesPath).events.listen(
      (event) {
        if (event.type == ChangeType.REMOVE) {
          String key = event.path.split(Constants.FILE_NAME_DELIMITER)[2];
          keys.removeWhere(
            (keyIterator) {
              if (keyIterator["tag"] == key) {
                print(key + "WIRD ENTFERNT");
                notifyListeners();
                return true;
              }
              return false;
            },
          );
        }
      },
    );
    if (images.length == 0) {
      setState(state: STATE.IMAGE_CACHE_LOG_NO_IMAGES);
    } else {
      setState(state: STATE.SUCCESS);
    }
  }

  void getImageDataFromFileNames(List images) {
    for (int i = 0; i < images.length; i++) {
      List<String> keyStrings =
          images[i].path.split(Constants.FILE_NAME_DELIMITER);

      keyStrings[0] = keyStrings[0].split("/").last;

      keys.add(
        {
          "path": images[i].path,
          "type": keyStrings[2] == " "
              ? CameraType.NEW_VEHICLE
              : CameraType.VEHICLE,
          "date": DateTime.fromMillisecondsSinceEpoch(int.parse(keyStrings[0])),
          "vehicle_id": keyStrings[1],
          "tag": keyStrings[2],
          "upload_process": keyStrings[3],
          "vin": keyStrings[4],
          "uploading": false,
        },
      );
    }
  }
}
