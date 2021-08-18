class Vehicle {
  int id;
  String vehicleNumber;
  String licensePlate;
  String vin;
  int constructionYear;
  Manufacturer manufacturer;
  VehicleCategory vehicleCategory;

  Vehicle(this.id, this.vehicleNumber, this.licensePlate, this.vin,
      this.constructionYear, this.manufacturer, this.vehicleCategory);
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
