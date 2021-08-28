import 'package:easyrent/models/wheel_type.dart';

class SuspensionType extends WheelType {
  SuspensionType(int id, String typeName) : super(id, typeName);

  factory SuspensionType.fromJson(Map<String, dynamic> json) {
    return SuspensionType(
      json["id"],
      json["type_name"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "type_name": typeName,
    };
  }
}
