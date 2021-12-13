import 'package:easyrent/models/contact.dart';

class Customer extends Contact {
  Customer(int id, String orgName, bool isPerson, String debitorNumber,
      String customerNumber)
      : super(id, orgName, isPerson, debitorNumber, customerNumber);

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      json["id"] ?? 0,
      json["org_name"] ?? "",
      json["is_person"] ?? false,
      json["debitor_number"] ?? "",
      json["customer_number"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "org_name": orgName,
      "is_person": isPerson,
      "debitor_number": debitorNumber,
      "customer_number": customerNumber
    };
  }
}
