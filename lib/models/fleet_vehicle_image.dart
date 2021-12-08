class FleetVehicleImage {
  int id;
  String vin;
  String filename;

  FleetVehicleImage(this.id, this.vin, this.filename);

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "vin": vin,
      "filename": filename,
    };
  }

  factory FleetVehicleImage.fromJson(Map<String, dynamic> json) {
    return FleetVehicleImage(json["id"], json["vin"], json["filename"]);
  }
}
