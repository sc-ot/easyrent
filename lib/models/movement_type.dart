class MovementType {
  int id;
  String typeName;

  MovementType(this.id, this.typeName);

  factory MovementType.fromJson(Map<String, dynamic> json) {
    return MovementType(
      json["id"] ?? 0,
      json["type_name"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "type_name": typeName,
    };
  }
}
