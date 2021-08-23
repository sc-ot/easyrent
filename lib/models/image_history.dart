import 'dart:convert';

class ImageHistory {
  List<String> imagePaths;
  String date;

  ImageHistory(this.imagePaths, this.date);

  factory ImageHistory.fromJson(Map<String, dynamic> json) {
    return ImageHistory(
      jsonDecode(
        json["image_paths"],
      ),
      json["date"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "image_paths": jsonEncode(imagePaths),
      "date": date,
    };
  }
}
