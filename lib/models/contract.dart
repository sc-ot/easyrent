import 'contact.dart';

class Contract{

  int id;
  String type;
  Contact? contact;
  String documentNumber;
  String documentDate;

  Contract(this.id, this.type, this.contact, this.documentNumber, this.documentDate);


  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "type": type,
      "contact": contact?.toJson(),
      "document_number": documentNumber,
      "document_date": documentDate,
    };
  }

  factory Contract.fromJson(Map<String, dynamic> json){
    return Contract(
      json["id"],
      json["type"],
      json["contact"] != null ? Contact.fromJson(json["contact"]) : null,
      json["document_number"],
      json["document_date"]
    );
  }
}
  