import 'dart:io';

import 'package:exif/exif.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

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
