class WheelType {
  int id;
  String typeName;

  WheelType(this.id, this.typeName);

  factory WheelType.fromJson(Map<String, dynamic> json) {
    return WheelType(
      json["id"],
      json["type_name"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "type_name": typeName,
    };
  }
}
