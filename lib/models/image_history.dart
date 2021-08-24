import 'dart:convert';

import 'package:easyrent/models/vehicle.dart';

class ImageHistory {
  List<String> imagePaths;
  String date;
  Vehicle? vehicle;
  String? vin;

  ImageHistory(this.imagePaths, this.date, this.vehicle, this.vin);

  factory ImageHistory.fromJson(Map<String, dynamic> json) {
    return ImageHistory(
      List<String>.from(
        jsonDecode(
          json["image_paths"],
        ),
      ),
      json["date"],
      json["vehicle"] != null ? Vehicle.fromJson(json["vehicle"]) : null,
      json["vin"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "image_paths": jsonEncode(imagePaths),
      "date": date,
      "vehicle": vehicle?.toJson(),
      "vin": vin,
    };
  }
}
