import 'package:easyrent/models/contact.dart';
import 'package:easyrent/models/report_type.dart';
import 'package:easyrent/models/status.dart';
import 'package:easyrent/models/vehicle.dart';

import 'category.dart';
import 'contract.dart';
import 'location.dart';

class InspectionReport {
  int id;
  Status? status;
  ReportType? reportType;
  String reportDate;
  List<Category> categories;
  Contact? contact;
  Contract? contract;
  Vehicle? vehicle;
  Vehicle? replacementForVehicle;
  int currentMileage;
  String nextGeneralInspectionDate;
  String nextSecurityInspectionDate;
  String nextSpeedoMeterInspectionDate;
  String nextUvvInspectionDate;
  String licensePlate;
  Location? location;
  String signature;
  String identification;
  String drivingLicense;
  String drivingLicenseBack;
  String screen;
  List<String> recipients;
  bool generateWorkshopOrder;
  bool receivedInstructions;

  InspectionReport? linkedReport;
  InspectionReport? previousReport;
  int allowedMileage;
  int allowedMileageTotal;
  int replacementVehicleMileage;
  double moreKmPrice;

  InspectionReport(
    this.id,
    this.status,
    this.reportType,
    this.reportDate,
    this.categories,
    this.contact,
    this.contract,
    this.vehicle,
    this.replacementForVehicle,
    this.currentMileage,
    this.nextGeneralInspectionDate,
    this.nextSecurityInspectionDate,
    this.nextSpeedoMeterInspectionDate,
    this.nextUvvInspectionDate,
    this.licensePlate,
    this.location,
    this.signature,
    this.identification,
    this.drivingLicense,
    this.drivingLicenseBack,
    this.screen,
    this.recipients,
    this.generateWorkshopOrder,
    this.receivedInstructions,
    this.linkedReport,
    this.previousReport,
    this.allowedMileage,
    this.allowedMileageTotal,
    this.replacementVehicleMileage,
    this.moreKmPrice,
  );

  factory InspectionReport.fromJson(Map<String, dynamic> json) {
    return InspectionReport(
      json["id"],
      json["status"] != null ? Status.fromJson(json["status"]) : null,
      json["report_type"] != null
          ? ReportType.fromJson(json["report_type"])
          : null,
      json["report_date"] ?? "",
      json["categories"] != null
          ? json["categories"]
              .map<Category>((element) => Category.fromJson(element))
              .toList()
          : [],
      json["contact"] != null ? Contact.fromJson(json["contact"]) : null,
      json["contract"] != null ? Contract.fromJson(json["contract"]) : null,
      json["vehicle"] != null ? Vehicle.fromJson(json["vehicle"]) : null,
      json["replacement_for_vehicle"] != null
          ? Vehicle.fromJson(json["replacement_for_vehicle"])
          : null,
      json["current_mileage"] ?? 0,
      json["next_general_inspection_date"] ?? "",
      json["next_security_inspection_date"] ?? "",
      json["next_speedometer_inspection_date"] ?? "",
      json["next_uvv_inspection_date"] ?? "",
      json["license_plate"] ?? "",
      json["location"] != null ? Location.fromJson(json["location"]) : null,
      json["signature"] ?? "",
      json["identification"] ?? "",
      json["driving_license"] ?? "",
      json["driving_license_back"] ?? "",
      json["screen"] ?? "",
      json["recipients"] != null
          ? json["recipients"]
              .map<String>((element) => element as String)
              .toList()
          : [],
      json["generate_workshop_order"] ?? false,
      json["received_instructions"] ?? false,
      json["linked_report"] != null
          ? InspectionReport.fromJson(json["linked_report"])
          : null,
      json["previous_report"] != null
          ? InspectionReport.fromJson(json["previous_report"])
          : null,
      json["allowed_mileage"] ?? 0,
      json["allowed_mileage_total"] ?? 0,
      json["replacement_vehicle_mileage"] ?? 0,
      json["more_km_price"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "status": status,
      "report_type": reportType,
      "report_date": reportDate,
      "categories": categories,
      "contact": contact,
      "contract": contract,
      "vehicle": vehicle,
      "replacement_for_vehicle": replacementForVehicle,
      "current_mileage": currentMileage,
      "next_general_inspection_date": nextGeneralInspectionDate,
      "next_security_inspection_date": nextSecurityInspectionDate,
      "next_speedometer_inspection_date": nextSpeedoMeterInspectionDate,
      "next_uvv_inspection_date": nextUvvInspectionDate,
      "license_plate": licensePlate,
      "location": location,
      "signature": signature,
      "identification": identification,
      "driving_license": drivingLicense,
      "driving_license_back": drivingLicenseBack,
      "screen": screen,
      "recipients": recipients,
      "generate_workshop_order": generateWorkshopOrder,
      "received_instructions": receivedInstructions,
      "linked_report": linkedReport,
      "previous_report": previousReport,
      "allowed_mileage": allowedMileage,
      "allowed_mileage_total": allowedMileageTotal,
      "replacement_vehicle_mileage": replacementVehicleMileage,
      "more_km_price": moreKmPrice,
    };
  }
}
