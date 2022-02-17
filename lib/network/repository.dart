import 'dart:convert';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:dartz/dartz.dart';

import 'package:easyrent/core/constants.dart';
import 'package:easyrent/models/accident.dart';
import 'package:easyrent/models/client.dart';
import 'package:easyrent/models/fleet_vehicle_image.dart';
import 'package:easyrent/models/fleet_vehicle_image_upload_process.dart';
import 'package:easyrent/models/image_upload_group.dart';
import 'package:easyrent/models/inspection_report.dart';
import 'package:easyrent/models/login.dart';
import 'package:easyrent/models/movement.dart';
import 'package:easyrent/models/planned_movement.dart';
import 'package:easyrent/models/vehicle.dart';
import 'package:easyrent/models/vehicle_image.dart';
import 'package:sc_appframework/models/failure.dart';
import 'package:sc_appframework/models/file_payload.dart';
import 'package:sc_appframework/network/sc_network_api.dart';

class EasyRentRepository {
  SCNetworkApi api = SCNetworkApi();

  static final EasyRentRepository _instance = EasyRentRepository._internal();
  factory EasyRentRepository() {
    _instance.api.baseUrl = Constants.BASE_URL;
    _instance.api.enableLog();
    return _instance;
  }

  EasyRentRepository._internal();

  Future<Either<Failure, dynamic>> loginUser(String body) => api.request<Login>(
        Method.POST,
        "system/login",
        body: body,
        serializer: (_) => Login.fromJson(_),
      );

  Future<Either<Failure, dynamic>> getClients() => api.request<Client>(
        Method.GET,
        "system/mandanten",
        responseType: ResponseType.LIST,
        serializer: (_) => Client.fromJson(_),
        retry: true,
      );

  Future<Either<Failure, dynamic>> getVehicle(int vehicleId) =>
      api.request<Vehicle>(
        Method.GET,
        "fleet/vehicles/$vehicleId",
        responseType: ResponseType.SINGLE,
        serializer: (_) => Vehicle.fromJson(_),
        retry: true,
      );

  Future<Either<Failure, dynamic>> getVehicles(
          int paging, String? searchQuery) =>
      api.request(
        Method.GET,
        "fleet/vehicles/basic-search",
        responseType: ResponseType.LIST,
        serializer: (_) => Vehicle.fromJson(_),
        searchQuery: searchQuery,
        page: paging,
        searchIn: searchQuery != null && searchQuery != ""
            ? [
                "vehicle_number",
                "license_plate",
                "vin",
              ]
            : null,
        retry: paging == 0 ? true : false,
      );

  Future<Either<Failure, dynamic>> getAllVehiclesWithExit(
          int paging, String? searchQuery) =>
      api.request(
        Method.GET,
        "fleet/app/vehicles/incoming",
        responseType: ResponseType.LIST,
        serializer: (_) => Vehicle.fromJson(_),
        searchQuery: searchQuery,
        page: paging,
        searchIn: searchQuery != null && searchQuery != ""
            ? [
                "vehicle_number",
                "license_plate",
                "vin",
              ]
            : null,
        retry: paging == 0 ? true : false,
      );

  Future<Either<Failure, dynamic>> getAllVehiclesWithEntry(
          int paging, String? searchQuery) =>
      api.request(
        Method.GET,
        "fleet/app/vehicles/outgoing",
        responseType: ResponseType.LIST,
        serializer: (_) => Vehicle.fromJson(_),
        searchQuery: searchQuery,
        page: paging,
        searchIn: searchQuery != null && searchQuery != ""
            ? [
                "vehicle_number",
                "license_plate",
                "vin",
              ]
            : null,
        retry: paging == 0 ? true : false,
      );

  Future<Either<Failure, dynamic>> getImageForVehicle(
    int vehicleId,
  ) =>
      api.request(
        Method.GET,
        "fleet/vehicles/$vehicleId/images",
        responseType: ResponseType.LIST,
        serializer: (_) => VehicleImage.fromJson(_),
        retry: true,
      );

  Future<Either<Failure, dynamic>> getImageLog() => api.request(
        Method.GET,
        "/fleet/vehicles/images/upload-process-groups",
        responseType: ResponseType.LIST,
        serializer: (_) => ImageUploadGroup.fromJson(_),
        retry: true,
      );

  Future<Either<Failure, dynamic>> getMovementsForVehicle(
    int vehicleId,
  ) =>
      api.request(
        Method.GET,
        "fleet/vehicles/$vehicleId/movements",
        responseType: ResponseType.LIST,
        serializer: (_) => Movement.fromJson(_),
        retry: true,
      );

  Future<Either<Failure, dynamic>> uploadImage(
          String baseUrl, int vehicleId, FilePayload filePayload, String tag,
          {Function(int, int)? onProgressCallback}) =>
      api.request(
        Method.MULTIPART,
        baseUrl + "/fleet/vehicles/$vehicleId/images/files",
        retry: true,
        cacheRequest: true,
        onProgress: (bytes, length) {
          if (onProgressCallback != null) {
            onProgressCallback(bytes, length);
          } else {
            if (bytes >= length) {
              print("\x1B[32m$tag - $bytes/$length\x1B[0m");
            }
            print("$tag - $bytes/$length");
          }
        },
        filePayload: filePayload,
        timeoutSeconds: 600,
      );

  Future<Either<Failure, dynamic>> getPlannedMovementsForToday(
          int movementType, String? searchQuery) =>
      api.request(
        Method.GET,
        movementType == Constants.MOVEMENT_TYPE_ENTRY
            ? "fleet/app/planned-movements/incoming"
            : "fleet/app/planned-movements/outgoing",
        responseType: ResponseType.LIST,
        serializer: (_) => PlannedMovement.fromJson(_),
        retry: true,
        searchQuery: searchQuery,
      );

  Future<Either<Failure, dynamic>> getPlannedMovementsForPast(
    int movementType,
    String? searchQuery,
  ) =>
      api.request(
        Method.GET,
        movementType == Constants.MOVEMENT_TYPE_ENTRY
            ? "fleet/app/planned-movements/incoming/passed"
            : "fleet/app/planned-movements/outgoing/passed",
        responseType: ResponseType.LIST,
        serializer: (_) => PlannedMovement.fromJson(_),
        retry: true,
        searchQuery: searchQuery,
      );

  Future<Either<Failure, dynamic>> getPlannedMovementsForFuture(
    int movementType,
    String? searchQuery,
  ) =>
      api.request(
        Method.GET,
        movementType == Constants.MOVEMENT_TYPE_ENTRY
            ? "fleet/app/planned-movements/incoming/future"
            : "fleet/app/planned-movements/outgoing/future",
        responseType: ResponseType.LIST,
        serializer: (_) => PlannedMovement.fromJson(_),
        retry: true,
        searchQuery: searchQuery,
      );

  Future<Either<Failure, dynamic>> getImageUploadProcess(int countImages) =>
      api.request(
        Method.GET,
        "fleet/vehicles/images/upload-process-groups/next?count_images=$countImages",
        responseType: ResponseType.SINGLE,
        serializer: (_) => FleetVehicleImageUploadProccess.fromJson(_),
        retry: true,
      );

  Future<Either<Failure, dynamic>> checkIfImageExists(String filename) =>
      api.request(
        Method.GET,
        "fleet/vehicles/images/exists",
        params: {"file_name": filename},
        responseType: ResponseType.SINGLE,
        serializer: (_) => FleetVehicleImage.fromJson(_),
        timeoutSeconds: 20,
      );

  Future<Either<Failure, dynamic>> getVehicleAccidents(int vehicleId) =>
      api.request(
        Method.GET,
        "fleet/vehicles/$vehicleId/accidents",
        responseType: ResponseType.LIST,
        serializer: (_) => Accident.fromJson(_),
        timeoutSeconds: 20,
      );

  Future<Either<Failure, dynamic>> generateInspectionReport(
    int reportTypeId,
    int vehicleId, {
    int? contractId,
    int? plannedMovementId,
  }) =>
      api.request(
        Method.GET,
        "fleet/inspection-reports/templates/1/generate",
        serializer: (_) => InspectionReport.fromJson(_),
        retry: true,
        params: {
          "report_type_id": reportTypeId.toString(),
          "vehicle_id": vehicleId.toString(),
          "contract_id": contractId?.toString(),
          "planned_movement_id": plannedMovementId?.toString(),
        },
      );

  Future<Either<Failure, dynamic>> getPdfDocument(
          InspectionReport inspectionReport) =>
      api.request(
        Method.POST,
        "fleet/inspection-reports/0/pdf",
        retry: false,
        decodeUtf8: true,
        body: jsonEncode(
          inspectionReport,
        ),
      );
}
