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