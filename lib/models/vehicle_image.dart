
class VehicleImage{

  int id;
  String fileName;
  String? imageUrl;



  VehicleImage(this.id, this.fileName);

   factory VehicleImage.fromJson(Map<String, dynamic> json) {
    return VehicleImage(
      json["id"] ?? 0,
      json["fileName"] ?? "",
    );
  }


}