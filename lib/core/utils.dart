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

  static String formatDateTimestring(String date) {
    try {
      DateTime parseDate = DateTime.parse(date);
      var outputFormat = DateFormat('dd.MM.yyyy');
      return outputFormat.format(parseDate);
    } catch (e) {
      return "";
    }
  }

  static String formatDateTimestringWithTime(String date) {
    try {
      DateTime parseDate = DateTime.parse(date);
      var outputFormat = DateFormat('dd.MM.yyyy - HH:mm');
      return outputFormat.format(parseDate);
    } catch (e) {
      return "";
    }
  }
}
