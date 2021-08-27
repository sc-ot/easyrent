class Location {
  int id;
  String locationName;

  Location(this.id, this.locationName);

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      json["id"] ?? 0,
      json["location_name"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "location_name": locationName,
    };
  }
}