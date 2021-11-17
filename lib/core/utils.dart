import 'dart:io';

import 'package:exif/exif.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
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

  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
