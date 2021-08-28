class ReportType {
  int id;
  String typeName;

  ReportType(this.id, this.typeName);

  factory ReportType.fromJson(Map<String, dynamic> json) {
    return ReportType(
      json["id"],
      json["type_name"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type_name'] = this.typeName;
    return data;
  }
}
