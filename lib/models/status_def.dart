class StatusDef {
  int id;
  String statusName;

  StatusDef(this.id, this.statusName);

  factory StatusDef.fromJson(Map<String, dynamic> json) {
    return StatusDef(
      json["id"] ?? 0,
      json["status_name"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "status_name": statusName,
    };
  }
}