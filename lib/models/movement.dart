import 'package:easyrent/models/vehicle.dart';

class Movement {
  int id;
  MovementType movementType;
  String movementDate;
  Contact contact;
  Vehicle vehicle;
  String licensePlate;
  String nextGeneralInspectionDate;
  String nextSecurityInspectionDate;
  String nextSpeedometerInspectionDate;
  String nextUvvInspectionDate;
  int currentMileage;

  Movement(
      this.id,
      this.movementType,
      this.movementDate,
      this.contact,
      this.vehicle,
      this.licensePlate,
      this.nextGeneralInspectionDate,
      this.nextSecurityInspectionDate,
      this.nextSpeedometerInspectionDate,
      this.nextUvvInspectionDate,
      this.currentMileage);

  factory Movement.fromJson(Map<String, dynamic> json) {
    return Movement(
      json["id"] ?? 0,
      json["movement_type"] != null
          ? MovementType.fromJson(json["movement_type"])
          : MovementType(0, ""),
      json["movement_date"] ?? "",
      json["contact"] != null
          ? Contact.fromJson(json["contact"])
          : Contact(0, "", false, "", ""),
      json["vehicle"] != null
          ? Vehicle.fromJson(json["vehicle"])
          : Vehicle.empty(),
      json["license_plate"] ?? "",
       json["next_general_inspection_date"] ?? "",
      json["next_security_inspection_date"] ?? "",
       json["next_speedometer_inspection_date"] ?? "",
      json["next_uvv_inspection_date"] ?? "",
      json["current_mileage"] ?? 0,
    );
  }
}

class MovementType {
  int id;
  String typeName;

  MovementType(this.id, this.typeName);

  factory MovementType.fromJson(Map<String, dynamic> json) {
    return MovementType(
      json["id"] ?? 0,
      json["type_name"] ?? "",
    );
  }
}

class Contact {
  int id;
  String orgName;
  bool isPerson;
  String debitorNumber;
  String customerNumber;

  Contact(this.id, this.orgName, this.isPerson, this.debitorNumber,
      this.customerNumber);

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      json["id"] ?? 0,
      json["org_name"] ?? "",
      json["is_person"] ?? false,
      json["debitor_number"] ?? "",
      json["customer_number"] ?? "",
    );
  }
}
