class ActionData {
  int id;
  String dataName;
  String defaultDataValue;
  bool isRequired;
  int orderValue;

  // tempValue for Checklist
  bool tempValue = false;

  ActionData(this.id, this.dataName, this.defaultDataValue, this.isRequired,
      this.orderValue);

  factory ActionData.fromJson(Map<String, dynamic> json) {
    return ActionData(
      json["id"] ?? 0,
      json["data_name"] ?? "",
      json["default_data_value"] ?? "",
      json["required"] ?? false,
      json["order_value"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "data_name": dataName,
      "default_data_value": defaultDataValue,
      "required": isRequired,
      "order_value": orderValue,
    };
  }
}
