import 'package:easyrent/models/contract.dart';
import 'package:easyrent/models/vehicle.dart';

import 'contact.dart';
import 'movement_type.dart';

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
  Contract? contract;

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
      this.currentMileage,
      this.contract);

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "movement_type": movementType.toJson(),
      "movement_date": movementDate,
      "contact": contact.toJson(),
      "vehicle": vehicle.toJson(),
      "license_plate": licensePlate,
      "next_general_inspection_date": nextGeneralInspectionDate,
      "next_security_inspection_date": nextSecurityInspectionDate,
      "next_speedometer_inspection_date": nextSpeedometerInspectionDate,
      "next_uvv_inspection_date": nextUvvInspectionDate,
      "current_mileage": currentMileage,
      "contract": contract?.toJson(),
    };
  }

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
      json["contract"] != null
          ? Contract.fromJson(
              json["contract"],
            )
          : null,
    );
  }
}
