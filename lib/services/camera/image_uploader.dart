import 'dart:io';

import 'package:easyrent/core/authenticator.dart';
import 'package:easyrent/core/constants.dart';
import 'package:easyrent/core/utils.dart';
import 'package:easyrent/network/repository.dart';
import 'package:sc_appframework/models/file_payload.dart';

class ImageUploader {
  static void uploadAllCachedImages() async {
    String imagesPath = await Utils.createFolderInAppDocDir("images");
    Directory dir = Directory(imagesPath);
    List<FileSystemEntity> listOfAllFolderAndFiles =
        await dir.list(recursive: false).toList();
    for (var dir in listOfAllFolderAndFiles) {
      await uoloadImageForImageGroup(int.parse(dir.path.split("/").last));
    }
  }

  static Future<void> uoloadImageForImageGroup(int uploadGroupId) async {
    String imagesPath =
        await Utils.createFolderInAppDocDir("images") + "$uploadGroupId" + "/";
    Directory dir = Directory(imagesPath);
    List<FileSystemEntity> images = [];
    List<Map<String, dynamic>> keys = [];
    EasyRentRepository easyRentRepository = EasyRentRepository();

    try {
      images = dir.listSync(recursive: true, followLinks: false);
    } catch (e) {
      return;
    }
    for (int i = 0; i < images.length; i++) {
      List<String> keyStrings =
          images[i].path.split(Constants.FILE_NAME_DELIMITER);

      keyStrings[0] = keyStrings[0].split("/").last;
      Map<String, dynamic> keys = {
        "path": images[i].path,
        "date": DateTime.fromMillisecondsSinceEpoch(int.parse(keyStrings[0])),
        "vehicle_id": keyStrings[1],
        "tag": keyStrings[2],
        "upload_process": keyStrings[3],
        "vin": keyStrings[4],
        "username": keyStrings[5],
        "vehicle_number": keyStrings[6],
      };

      Map<String, String> filePayloadParams = {
        "created_at": DateTime.now().toIso8601String(),
        "client": Authenticator.getUsername(),
        "images_count": images.length.toString(),
        "is_favorite":
            keys["tag"] == "Frontal-Links" || keys["tag"] == "Heck-Rechts"
                ? "1"
                : "0",
        "upload_process": keys["upload_process"],
        "tag": keys["tag"],
        "vin": keys["vin"],
        "username": keys["username"],
        "vehicle_number": keys["vehicle_number"],
      };

      var result = await easyRentRepository.uploadImage(
        int.parse(keys["vehicle_id"]),
        FilePayload(
          images[i].path,
          filePayloadParams,
          deleteFile: true,
        ),
        keys["tag"],
      );
    }
    try {
      await dir.delete();
    } catch (e) {
      print(e);
    }
  }
}
