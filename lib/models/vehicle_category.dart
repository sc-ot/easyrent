class VehicleCategory {
  int id;
  String vehicleCategoryName;
  bool isTowingVehicle;
  bool isMotorVehicle;
  bool isConstructionVehicle;
  bool isConstructionTurnover;
  bool isTrailer;
  bool isSemiTrailer;
  bool isSpecialEquipment;
  bool isTransporter;

/*
"is_towing_vehicle": false,
                "is_motor_vehicle": true,
                "is_construction_vehicle": false,
                "is_cooling_vehicle": false,
                "is_construction_turnover": false,
                "is_trailer": false,
                "is_semi_trailer": false,
                "is_special_equipment": false,
                "is_transporter": false,
*/
  VehicleCategory(
      this.id,
      this.vehicleCategoryName,
      this.isTowingVehicle,
      this.isMotorVehicle,
      this.isConstructionVehicle,
      this.isConstructionTurnover,
      this.isTrailer,
      this.isSemiTrailer,
      this.isSpecialEquipment,
      this.isTransporter);

  factory VehicleCategory.fromJson(Map<String, dynamic> json) {
    return VehicleCategory(
      json["id"] ?? 0,
      json["vehicle_category_name"] ?? "",
      json["is_towing_vehicle"] ?? false,
      json["is_motor_vehicle"] ?? false,
      json["is_construction_vehicle"] ?? false,
      json["is_construction_turnover"] ?? false,
      json["is_trailer"] ?? false,
      json["is_semi_trailer"] ?? false,
      json["is_special_equipment"] ?? false,
      json["is_transporter"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "vehicle_category_name": vehicleCategoryName,
      "is_towing_vehicle": isTowingVehicle,
      "is_motor_vehicle": isMotorVehicle,
      "is_construction_vehicle": isConstructionVehicle,
      "is_construction_turnover": isConstructionTurnover,
      "is_trailer": isTrailer,
      "is_semi_trailer": isSemiTrailer,
      "is_special_equipment": isSpecialEquipment,
      "is_transporter": isTransporter,
    };
  }
}
