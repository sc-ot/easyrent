import 'dart:async';
import 'dart:io';

import 'package:easyrent/core/constants.dart';
import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/core/utils.dart';
import 'package:easyrent/network/repository.dart';
import 'package:easyrent/services/camera/camera_page.dart';
import 'package:sc_appframework/models/file_payload.dart';
import 'package:sc_appframework/network/sc_cache_request_handler.dart';
import 'package:sc_appframework/network/sc_network_api.dart';
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
                return true;
              }
              return false;
            },
          );
          setState(state: STATE.SUCCESS);
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
          "on_progress_callback": null,
          "uploading": false,
        },
      );
    }

    for (var key in keys) {
      List<SCCachedRequest> cachedRequests = SCNetworkApi().cachedRequests;
      for (var cachedRequest in cachedRequests) {
        if (cachedRequest.method == Method.MULTIPART &&
            cachedRequest.filePayload != null &&
            cachedRequest.filePayload!.filePath == key["path"]) {
          key["uploading"] = true;
        }
      }
    }
  }

  void uploadImage(Map<String, dynamic> key) {
    /*Function(int, int) onProgressCallback = (send, max) {
      keys[index]["send"] = send;
      keys[index]["max"] = max;
      double progress = (keys[index]["send"] / keys[index]["max"] * 1);
      progress = progress.toPrecision(1);
      keys[index]["progress"] = progress;
      print(progress);
      double step = progress % 0.1;

      if (step == 0) {
        setState(state: STATE.SUCCESS);
      }
    };

    keys[index]["on_progress_callback"] = onProgressCallback;*/

    Map<String, String> paramKeys = {};
    if (key["type"] == CameraType.NEW_VEHICLE) {
      paramKeys = {
        "tag": key["tag"],
        "upload_process": key["upload_process"],
        "is_favorite":
            key["tag"] == "Frontal-Links" || key["tag"] == "Heck-Rechts"
                ? "1"
                : "0",
      };
    } else {
      paramKeys = {
        "tag": key["tag"],
        "upload_process": key["upload_process"],
        "is_favorite":
            key["tag"] == "Frontal-Links" || key["tag"] == "Heck-Rechts"
                ? "1"
                : "0",
      };
    }
    try {
      key["uploading"] = true;
      setState(state: STATE.SUCCESS);
      easyRentRepository
          .uploadImage(
            int.parse(key["vehicle_id"]),
            FilePayload(key["path"], paramKeys, deleteFile: true),
            key["tag"],
          )
          .asStream()
          .listen(
        (event) {
          event.fold(
            (failure) {},
            (r) {
              keys.removeWhere((keyIterator) {
                if (keyIterator["tag"] == key["tag"]) {
                  print(key["tag"] + "WIRD ENTFERNT");

                  return true;
                }
                return false;
              });
              setState(state: STATE.SUCCESS);
            },
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
