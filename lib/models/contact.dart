class Contact {
  int id;
  String orgName;
  bool isPerson;
  String debitorNumber;
  String customerNumber;

  Contact(this.id, this.orgName, this.isPerson, this.debitorNumber,
      this.customerNumber);

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
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
