import 'package:easyrent/models/customer.dart';
import 'package:easyrent/models/scheduling_status.dart';
import 'package:easyrent/models/status.dart';
import 'package:easyrent/models/status_def.dart';
import 'package:easyrent/models/vehicle_axis_profile.dart';
import 'package:easyrent/models/vehicle_category.dart';

import 'contract.dart';
import 'engine_type.dart';
import 'linked_vehicle_equipment.dart';
import 'location.dart';
import 'manufacturer.dart';
import 'movement.dart';

class Vehicle {
  int id;
  String vehicleNumber;
  String licensePlate;
  String vin;
  int constructionYear;
  Manufacturer manufacturer;
  VehicleCategory vehicleCategory;
  String letterNumber;
  int kilowatt;
  int horsePower;
  double emptyWeight;
  double allowedTotalWeight;
  double payloadWeight;
  int totalLength;
  int totalHeight;
  int totalWidth;
  int countAxis;
  String firstRegistrationDate;
  EngineType engineType;
  Status status;
  SchedulingStatus? schedulingStatus;

  Location location;

  String nextGeneralInspectionDate;
  String nextSecurityInspectionDate;
  String nextSpeedoMeterInspectionDate;
  String nextUvvInspectionDate;
  String notes;
  List<LinkedVehicleEquipment> linkedVehicleEquipments;
  Movement? lastMovement;
  Contract? currentContract;
  Contract? lastContract;
  AxisProfile? axisProfile;

  Vehicle(
    this.id,
    this.vehicleNumber,
    this.licensePlate,
    this.vin,
    this.constructionYear,
    this.manufacturer,
    this.vehicleCategory,
    this.letterNumber,
    this.kilowatt,
    this.horsePower,
    this.emptyWeight,
    this.allowedTotalWeight,
    this.payloadWeight,
    this.totalLength,
    this.totalHeight,
    this.totalWidth,
    this.countAxis,
    this.firstRegistrationDate,
    this.engineType,
    this.status,
    this.location,
    this.nextGeneralInspectionDate,
    this.nextSecurityInspectionDate,
    this.nextSpeedoMeterInspectionDate,
    this.nextUvvInspectionDate,
    this.notes,
    this.linkedVehicleEquipments,
    this.lastMovement,
    this.currentContract,
    this.schedulingStatus,
    this.lastContract,
    this.axisProfile,
  );
  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      json["id"] ?? 0,
      json["vehicle_number"] ?? "",
      json["license_plate"] ?? "",
      json["vin"] ?? "",
      json["construction_year"] ?? 0,
      json["manufacturer"] != null
          ? Manufacturer.fromJson(json["manufacturer"])
          : Manufacturer(0, ""),
      json["vehicle_category"] != null
          ? VehicleCategory.fromJson(json["vehicle_category"])
          : VehicleCategory(
              0, "", false, false, false, false, false, false, false, false),
      json["letter_number"] ?? "",
      json["kilowatt"] ?? 0,
      json["horsepower"] ?? 0,
      json["empty_weight"] ?? 0,
      json["allowed_total_weight"] ?? 0,
      json["payload_weight"] ?? 0,
      json["total_length"] ?? 0,
      json["total_height"] ?? 0,
      json["total_width"] ?? 0,
      json["count_axis"] ?? 0,
      json["first_registration_date"] ?? "",
      json["engine_type"] != null
          ? EngineType.fromJson(json["engine_type"])
          : EngineType(0, ""),
      json["status"] != null
          ? Status.fromJson(json["status"])
          : Status(
              0,
              StatusDef(0, ""),
            ),
      json["location"] != null
          ? Location.fromJson(json["location"])
          : Location(0, ""),
      json["next_general_inspection_date"] ?? "",
      json["next_security_inspection_date"] ?? "",
      json["next_speedometer_inspection_date"] ?? "",
      json["next_uvv_inspection_date"] ?? "",
      json["notes"] ?? "",
      json["linked_vehicle_equipments"] != null
          ? List<LinkedVehicleEquipment>.from(
              json["linked_vehicle_equipments"]
                  .map((x) => LinkedVehicleEquipment.fromJson(x)),
            )
          : [],
      json["last_movement"] != null
          ? Movement.fromJson(json["last_movement"])
          : null,
      json["current_contract"] != null
          ? Contract.fromJson(json["current_contract"])
          : null,
      json["scheduling_status"] != null
          ? SchedulingStatus.fromJson(json["scheduling_status"])
          : null,
      json["last_contract"] != null
          ? Contract.fromJson(json["last_contract"])
          : null,
      json["axis_profile"] != null
          ? AxisProfile.fromJson(json["axis_profile"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "vehicle_number": vehicleNumber,
      "license_plate": licensePlate,
      "vin": vin,
      "construction_year": constructionYear,
      "manufacturer": manufacturer,
      "vehicle_category": vehicleCategory,
      "letter_number": letterNumber,
      "kilowatt": kilowatt,
      "horsepower": horsePower,
      "allowed_total_height": allowedTotalWeight,
      "payload_weight": payloadWeight,
      "total_length": totalLength,
      "total_height": totalHeight,
      "total_width": totalWidth,
      "count_axis": countAxis,
      "first_registration_date": firstRegistrationDate,
      "engine_type": engineType,
      "status": status,
      "location": location,
      "next_general_inspection_date": nextGeneralInspectionDate,
      "next_security_inspection_date": nextSecurityInspectionDate,
      "next_speedometer_inspection_date": nextSpeedoMeterInspectionDate,
      "next_uvv_inspection_date": nextUvvInspectionDate,
      "notes": notes,
      "linked_vehicle_equipments": linkedVehicleEquipments,
      "last_movement": lastMovement,
      "current_contract": currentContract,
      "scheduling_status": schedulingStatus,
      "last_contract": lastContract,
      "axis_profile": axisProfile,
    };
  }

  factory Vehicle.empty() {
    return Vehicle(
      0,
      "",
      "",
      "",
      0,
      Manufacturer(0, ""),
      VehicleCategory(
          0, "", false, false, false, false, false, false, false, false),
      "",
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      "",
      EngineType(0, ""),
      Status(
        0,
        StatusDef(0, ""),
      ),
      Location(0, ""),
      "",
      "",
      "",
      "",
      "",
      [],
      null,
      null,
      SchedulingStatus(
        "",
        StatusDef(
          0,
          "",
        ),
        "",
        Customer(0, "", false, "", ""),
      ),
      null,
      AxisProfile(
        0,
        "",
        [],
      ),
    );
  }
}
