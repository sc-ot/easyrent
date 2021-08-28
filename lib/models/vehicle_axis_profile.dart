import 'axis.dart';

class VehicleAxisProfile {
  int id;
  String date;
  List<Axis> axis;

  VehicleAxisProfile(this.id, this.date, this.axis);

  factory VehicleAxisProfile.fromJson(Map<String, dynamic> json) {
    return VehicleAxisProfile(
      json["id"],
      json["date"],
      json["axis"] != null
          ? json["axis"].map<Axis>((element) => Axis.fromJson(element)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "date": date,
      "axis": List<Axis>.from(
        axis.map(
          (x) => x.toJson(),
        ),
      ),
    };
  }
}
