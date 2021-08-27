import 'fleet_vehicle_equipment.dart';
import 'manufacturer.dart';

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