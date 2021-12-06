class ImageUploadGroup {
  String createdAt;
  String vin;
  int takenPictures;
  String firstName;
  String vehicleNumber;
  int imagesCount;
  int imageUploadGroupProcessId;

  ImageUploadGroup(this.createdAt, this.vin, this.takenPictures, this.firstName,
      this.vehicleNumber, this.imagesCount, this.imageUploadGroupProcessId);

  factory ImageUploadGroup.fromJson(Map<String, dynamic> json) {
    return ImageUploadGroup(
      json["created_at"],
      json["vin"],
      json["taken_images"] ?? -1,
      json["first_name"],
      json["vehicle_number"],
      json["images_count"] ?? -1,
      json["fleet_vehicle_image_upload_groups_process_id"],
    );
  }
}
