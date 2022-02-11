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
  int currentMilleage;
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
  int allowedMileage;
  int allowedMileageTotal;
  int replacementVehicleMileage;
  double moreKmPrice;

  InspectionReport? linkedReport;
  InspectionReport? previousReport;
  int allowedMilleage;
  int allowedMilleageTotal;

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
    this.currentMilleage,
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
    this.allowedMilleage,
    this.allowedMilleageTotal,
    this.replacementVehicleMileage,
    this.moreKmPrice,
    this.allowedMileage,
    this.allowedMileageTotal,
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
      json["allowed_mileage"] ?? 0,
      json["allowed_mileage_total"] ?? 0,
    );
  }
}
