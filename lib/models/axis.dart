import 'package:easyrent/models/suspension_type.dart';
import 'package:easyrent/models/wheel.dart';
import 'package:easyrent/models/wheel_type.dart';

class Axis {
  int id;
  SuspensionType? suspensionType;
  WheelType? wheelType;
  List<Wheel> wheelsLeft;
  List<Wheel> wheelsRight;

  Axis(this.id, this.suspensionType, this.wheelType, this.wheelsLeft,
      this.wheelsRight);

  factory Axis.fromJson(Map<String, dynamic> json) {
    return Axis(
      json["id"],
      json["suspension_type"] != null
          ? SuspensionType.fromJson(json["suspension_type"])
          : null,
      json["wheel_type"] != null
          ? WheelType.fromJson(json["wheel_type"])
          : null,
      json["wheels_left"] != null
          ? json["wheels_left"]
              .map<Wheel>(
                (element) => Wheel.fromJson(element),
              )
              .toList()
          : [],
      json["wheels_right"] != null
          ? json["wheels_right"]
              .map<Wheel>(
                (element) => Wheel.fromJson(element),
              )
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "suspension_type": suspensionType?.toJson(),
      "wheels_left": List<Wheel>.from(
        wheelsLeft.map(
          (x) => x.toJson(),
        ),
      ),
      "wheels_right": List<Wheel>.from(
        wheelsRight.map(
          (x) => x.toJson(),
        ),
      ),
    };
  }
}
