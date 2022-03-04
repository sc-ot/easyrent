import 'axis.dart';

class AxisProfile {
  int id;
  String date;
  List<Axis> axis;

  AxisProfile(this.id, this.date, this.axis);

  factory AxisProfile.fromJson(Map<String, dynamic> json) {
    return AxisProfile(
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
