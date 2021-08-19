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
    try{

    
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd.MM.yyyy');
    return outputFormat.format(inputDate);
    }
    catch(e){
      return "";
    }
  }
}
