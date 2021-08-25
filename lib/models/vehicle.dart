
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
    this.engineType,
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
          ? json["linked_vehicle_equipments"]
              .map<LinkedVehicleEquipment>(
                  (element) => LinkedVehicleEquipment.fromJson(element))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "vehicle_number": vehicleNumber,
      "license_plate": licensePlate,
      "vin": vin,
      "construction_year": constructionYear,
      "manufacturer": manufacturer.toJson(),
      "vehicle_category": vehicleCategory.toJson(),
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
      "engine_type": engineType.toJson(),
      "status": status,
      "location": location.toJson(),
      "next_general_inspection_date": nextGeneralInspectionDate,
      "next_security_inspection_date": nextSecurityInspectionDate,
      "next_speedometer_inspection_date": nextSpeedoMeterInspectionDate,
      "next_uvv_inspection_date": nextUvvInspectionDate,
      "notes": notes,
      "linked_vehicle_equipments": List<dynamic>.from(
        linkedVehicleEquipments.map(
          (x) => x.toJson(),
        ),
      ),
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

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "manufacturer_name": manufacturerName,
    };
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

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "vehicle_category_name": vehicleCategoryName,
    };
  }
}

class EngineType {
  int id;
  String engineTypeName;

  EngineType(this.id, this.engineTypeName);

  factory EngineType.fromJson(Map<String, dynamic> json) {
    return EngineType(
      json["id"] ?? 0,
      json["engine_type_name"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "engine_type_name": engineTypeName,
    };
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

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "status_def": statusDef.toJson(),
    };
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

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "status_name": statusName,
    };
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

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "location_name": locationName,
    };
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
          ? FleetVehicleEquipment.fromJson(
              json["fleet_vehicle_equipment"],
            )
          : FleetVehicleEquipment(0, Manufacturer(0, ""), "", ""),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "fleet_vehicle_equipment": fleetVehicleEquipment.toJson(),
    };
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

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "manufacturer": manufacturer.toJson(),
      "equipment_name": equipmentName,
      "equipment_code": equipmentCode,
    };
  }
}
