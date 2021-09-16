import 'dart:convert';

import 'package:easyrent/models/vehicle.dart';

class ImageHistory {
  String client;
  List<String> imagePaths;
  String date;
  Vehicle? vehicle;
  String? vin;

  ImageHistory(this.client, this.imagePaths, this.date, this.vehicle, this.vin);

  factory ImageHistory.fromJson(Map<String, dynamic> json) {
    return ImageHistory(
      json["client"],
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
      "client": client,
      "image_paths": jsonEncode(imagePaths),
      "date": date,
      "vehicle": vehicle?.toJson(),
      "vin": vin,
    };
  }
}
