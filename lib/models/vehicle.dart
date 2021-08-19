import 'dart:collection';

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
  EnginType enginType;
  Status status;
  Location location;

  String nextGeneralInspectionDate;
  String nextSecurityInspectionDate;
  String nextSpeedoMeterInspectionDate;
  String nextUvvInspectionDate;
  String notes;
  List<LinkedVehicleEquipment> linkedVehicleEquipments;

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
    this.enginType,
    this.status,
    this.location,
    this.nextGeneralInspectionDate,
    this.nextSecurityInspectionDate,
    this.nextSpeedoMeterInspectionDate,
    this.nextUvvInspectionDate,
    this.notes,
    this.linkedVehicleEquipments,
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
          : VehicleCategory(0, ""),
      json["letter_number"] ?? "",
      json["kilowatt"] ?? 0,
      json["horsepower"] ?? 0,
      json["empty_weight"] ?? 0,
      json["allowed_total_weight"] ?? 0,
      json["payload_weight"] ?? 0,
      json["total_length"] ?? 0,
      json["total_height"] ?? 0,
      json["total_width"] ?? 0,
      json["total_length"] ?? 0,
      json["first_registration_date"] ?? "",
      json["engin_type"] != null
          ? EnginType.fromJson(json["engin_type"])
          : EnginType(0, ""),
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
          ? json["linked_vehicle_equipments"]
              .map<LinkedVehicleEquipment>((element) => LinkedVehicleEquipment.fromJson(element))
              .toList()
          : LinkedVehicleEquipment(
              0,
              FleetVehicleEquipment(0, Manufacturer(0, ""), "", ""),
            ),
    );
  }

  factory Vehicle.empty() {
    return Vehicle(
      0,
      "",
      "",
      "",
      0,
      Manufacturer(0, ""),
      VehicleCategory(0, ""),
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
      EnginType(0, ""),
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
    );
  }
}

class Manufacturer {
  int id;
  String manufacturerName;

  Manufacturer(this.id, this.manufacturerName);
  factory Manufacturer.fromJson(Map<String, dynamic> json) {
    return Manufacturer(
      json["id"] ?? 0,
      json["manufacturer_name"] ?? "",
    );
  }
}

class VehicleCategory {
  int id;
  String vehicleCategoryName;

  VehicleCategory(this.id, this.vehicleCategoryName);

  factory VehicleCategory.fromJson(Map<String, dynamic> json) {
    return VehicleCategory(
      json["id"] ?? 0,
      json["vehicle_category_name"] ?? "",
    );
  }
}

class EnginType {
  int id;
  String enginTypeName;

  EnginType(this.id, this.enginTypeName);

  factory EnginType.fromJson(Map<String, dynamic> json) {
    return EnginType(
      json["id"] ?? 0,
      json["engin_type_name"] ?? "",
    );
  }
}

class Status {
  int id;
  StatusDef statusDef;

  Status(this.id, this.statusDef);

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      json["id"] ?? 0,
      json["status_def"] != null
          ? StatusDef.fromJson(json["status_def"])
          : StatusDef(0, ""),
    );
  }
}

class StatusDef {
  int id;
  String statusName;

  StatusDef(this.id, this.statusName);

  factory StatusDef.fromJson(Map<String, dynamic> json) {
    return StatusDef(
      json["id"] ?? 0,
      json["status_name"] ?? "",
    );
  }
}

class Location {
  int id;
  String locationName;

  Location(this.id, this.locationName);

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      json["id"] ?? 0,
      json["location_name"] ?? "",
    );
  }
}

class LinkedVehicleEquipment {
  int id;
  FleetVehicleEquipment fleetVehicleEquipment;

  LinkedVehicleEquipment(this.id, this.fleetVehicleEquipment);

  factory LinkedVehicleEquipment.fromJson(Map<String, dynamic> json) {
    return LinkedVehicleEquipment(
      json["id"] ?? 0,
      json["fleet_vehicle_equipment"] != null
          ? FleetVehicleEquipment.fromJson(json["fleet_vehicle_equipment"])
          : FleetVehicleEquipment(0, Manufacturer(0, ""), "", ""),
    );
  }
}

class FleetVehicleEquipment {
  int id;
  Manufacturer manufacturer;
  String equipmentName;
  String equipmentCode;

  FleetVehicleEquipment(
      this.id, this.manufacturer, this.equipmentName, this.equipmentCode);

  factory FleetVehicleEquipment.fromJson(Map<String, dynamic> json) {
    return FleetVehicleEquipment(
      json["id"] ?? 0,
      json["manufacturer"] != null
          ? Manufacturer.fromJson(json["manufacturer"])
          : Manufacturer(0, ""),
      json["equipment_name"] ?? "",
      json["equipment_code"] ?? "",
    );
  }
}
