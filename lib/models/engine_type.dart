class EngineType {
  int id;
  String engineTypeName;

  EngineType(this.id, this.engineTypeName);

  factory EngineType.fromJson(Map<String, dynamic> json) {
    return EngineType(
      json["id"] ?? 0,
      json["engine_type_name"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "engine_type_name": engineTypeName,
    };
  }
}