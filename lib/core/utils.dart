import 'dart:io';

import 'package:exif/exif.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

enum Device {
  TABLET,
  PHONE,
}

class Utils {
  static Device getDevice(BuildContext context) {
    if (MediaQuery.of(context).size.width > 600) {
      return Device.TABLET;
    } else {
      return Device.PHONE;
    }
  }

  static String formatDateTimestring(String date, {String onError = ""}) {
    try {
      DateTime parseDate = DateTime.parse(date);
      var outputFormat = DateFormat('dd.MM.yyyy');
      return outputFormat.format(parseDate);
    } catch (e) {
      return onError;
    }
  }

  static String formatDateTimestringWithTime(String date,
      {String onError = ""}) {
    try {
      DateTime parseDate = DateTime.parse(date);
      var outputFormat = DateFormat('dd.MM.yyyy - HH:mm');
      return outputFormat.format(parseDate);
    } catch (e) {
      return onError;
    }
  }

  static Future<String> createFolderInAppDocDir(String folderName) async {
    //Get this App Document Directory
    final Directory _appDocDir = await getApplicationDocumentsDirectory();
    //App Document Directory + folder name
    final Directory _appDocDirFolder =
        Directory('${_appDocDir.path}/$folderName/');

    if (await _appDocDirFolder.exists()) {
      //if folder already exists return path
      return _appDocDirFolder.path;
    } else {
      //if folder not exists create folder and then return its path
      final Directory _appDocDirNewFolder =
          await _appDocDirFolder.create(recursive: true);
      return _appDocDirNewFolder.path;
    }
  }

  static Future<File> moveFile(File sourceFile, String newPath) async {
    try {
      /// prefer using rename as it is probably faster
      /// if same directory path
      return await sourceFile.rename(newPath);
    } catch (e) {
      /// if rename fails, copy the source file
      final newFile = await sourceFile.copy(newPath);
      return newFile;
    }
  }

  static printExifOf(String path) async {
    Map<String, IfdTag> data =
        await readExifFromBytes(await File(path).readAsBytes());

    if (data.isEmpty) {
      print("No EXIF information found\n");
      return;
    }

    if (data.containsKey('JPEGThumbnail')) {
      print('File has JPEG thumbnail');
      data.remove('JPEGThumbnail');
    }
    if (data.containsKey('TIFFThumbnail')) {
      print('File has TIFF thumbnail');
      data.remove('TIFFThumbnail');
    }

    for (String key in data.keys) {
      print("$key (${data[key]?.tagType}): ${data[key]}");
    }
  }
}
