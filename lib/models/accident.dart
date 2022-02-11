import 'package:easyrent/models/accident_type.dart';

class Accident {
  String accidentDate;
  AccidentType? accidentType;

  bool hasWarning;

  Accident(this.accidentDate, this.accidentType, this.hasWarning);

  factory Accident.fromJson(Map<String, dynamic> json) {
    return Accident(
      json["accident_date"] ?? "",
      json["accident_type"] != null
          ? AccidentType.fromJson(json["accident_type"])
          : null,
      json["has_warning"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "accident_date": accidentDate,
      "accident_Type": AccidentType,
      "has_warning": hasWarning,
    };
  }
}
