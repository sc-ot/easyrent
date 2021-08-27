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

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "manufacturer_name": manufacturerName,
    };
  }
}