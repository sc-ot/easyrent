class AccidentType {
  int id;
  String typeName;
  double worstValue;
  bool isAccident;

  AccidentType(this.id, this.typeName, this.worstValue, this.isAccident);

  factory AccidentType.fromJson(Map<String, dynamic> json) {
    return AccidentType(
      json["id"],
      json["type_name"] ?? "",
      json["worst_value"] != null ? json["worst_value"].toDouble() : 0,
      json["is_accident"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "type_name": typeName,
      "worst_value": worstValue,
      "is_accident": isAccident,
    };
  }
}
