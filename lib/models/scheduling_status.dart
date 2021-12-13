import 'package:easyrent/models/customer.dart';
import 'package:easyrent/models/status_def.dart';

class SchedulingStatus {
  String statusName;
  StatusDef statusDef;
  String notice;
  Customer customer;

  SchedulingStatus(this.statusName, this.statusDef, this.notice, this.customer);

  factory SchedulingStatus.fromJson(Map<String, dynamic> json) {
    return SchedulingStatus(
      json["status_name"],
      StatusDef.fromJson(json["status_def"]),
      json["notice"],
      Customer.fromJson(json["customer"]),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_name'] = this.statusName;
    data['status_def'] = this.statusDef;
    data['notice'] = this.notice;
    data['customer'] = this.customer;
    return data;
  }
}
