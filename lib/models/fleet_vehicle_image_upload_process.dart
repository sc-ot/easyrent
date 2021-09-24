class FleetVehicleImageUploadProccess {
  int id;

  FleetVehicleImageUploadProccess(this.id);

  factory FleetVehicleImageUploadProccess.fromJson(Map<String, dynamic> json) {
    return FleetVehicleImageUploadProccess(json["id"]);
  }

  Map<String, dynamic> toJson() {
    return {"id": id};
  }
}
