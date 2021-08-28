import 'package:easyrent/models/contract.dart';
import 'package:easyrent/models/vehicle.dart';

import 'contact.dart';
import 'movement_type.dart';

class PlannedMovement {
  int id;
  int statusId;
  MovementType movementType;
  String movementDate;
  Contact contact;
  Vehicle vehicle;
  int inspectionReportCountAnswered;
  int inspectionReportCountTotal;
  Contract? contract;

  PlannedMovement(
      this.id,
      this.statusId,
      this.movementType,
      this.movementDate,
      this.contact,
      this.vehicle,
      this.inspectionReportCountAnswered,
      this.inspectionReportCountTotal,
      this.contract);

  factory PlannedMovement.fromJson(Map<String, dynamic> json) {
    return PlannedMovement(
      json["id"],
      json["status_id"],
      MovementType.fromJson(json["movement_type"]),
      json["movement_date"],
      Contact.fromJson(json["contact"]),
      Vehicle.fromJson(json["vehicle"]),
      json["inspection_report_count_answered"],
      json["inspection_report_count_total"],
      json["contract"] != null ? Contract.fromJson(json["contract"]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "status_id": statusId,
      "movement_type": movementType.toJson(),
      "movement_date": movementDate,
      "contact": contact.toJson(),
      "vehicle": vehicle.toJson(),
      "inspection_report_count_answered": inspectionReportCountAnswered,
      "inspection_report_count_total": inspectionReportCountTotal,
      "contract": contract,
    };
  }
}
