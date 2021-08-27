import 'manufacturer.dart';

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