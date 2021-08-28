import 'package:easyrent/models/wheel_type.dart';

class Wheel {
  int id;
  String wheelPosition;
  String wheelPositionOnAxis;
  WheelType? wheelType;
  int tyreTread;

  Wheel(this.id, this.wheelPosition, this.wheelPositionOnAxis, this.wheelType,
      this.tyreTread);

  factory Wheel.fromJson(Map<String, dynamic> json) {
    return Wheel(
      json["id"],
      json["wheel_position"],
      json["wheel_position_on_axis"],
      json["wheel_type"] != null
          ? WheelType.fromJson(json["wheel_type"])
          : null,
      json["tyre_tread"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "wheel_position": wheelPosition,
      "wheel_position_on_axis": wheelPositionOnAxis,
      "wheel_type": wheelType?.toJson(),
      "tyre_tread": tyreTread,
    };
  }
}
