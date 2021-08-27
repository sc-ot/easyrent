import 'package:easyrent/models/status_def.dart';

class Status {
  int id;
  StatusDef statusDef;

  Status(this.id, this.statusDef);

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      json["id"] ?? 0,
      json["status_def"] != null
          ? StatusDef.fromJson(json["status_def"])
          : StatusDef(0, ""),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "status_def": statusDef.toJson(),
    };
  }
}