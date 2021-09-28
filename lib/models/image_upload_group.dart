class ImageUploadGroup {
  String createdAt;
  String vin;
  int takenPictures;
  String firstName;
  String vehicleNumber;

  ImageUploadGroup(this.createdAt, this.vin, this.takenPictures, this.firstName,
      this.vehicleNumber);

  factory ImageUploadGroup.fromJson(Map<String, dynamic> json) {
    return ImageUploadGroup(
      json["created_at"],
      json["vin"],
      json["taken_pictures"],
      json["first_name"],
      json["vehicle_number"],
    );
  }
}
