import 'package:flutter/cupertino.dart';

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
}
