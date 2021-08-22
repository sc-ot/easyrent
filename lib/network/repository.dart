import 'package:dartz/dartz.dart';
import 'package:devtools/api.dart';
import 'package:devtools/models/failure.dart';
import 'package:devtools/models/file_payload.dart';
import 'package:easyrent/core/constants.dart';
import 'package:easyrent/models/client.dart';
import 'package:easyrent/models/login.dart';
import 'package:easyrent/models/movement.dart';
import 'package:easyrent/models/vehicle.dart';
import 'package:easyrent/models/vehicle_image.dart';

class EasyRentRepository {
  Api api = Api();

  static final EasyRentRepository _instance = EasyRentRepository._internal();
  factory EasyRentRepository() {
    _instance.api.baseUrl = Constants.BASE_URL;
    _instance.api.enableLog = true;
    return _instance;
  }

  EasyRentRepository._internal();

  Future<Either<Failure, dynamic>> loginUser(String body) => api.request<Login>(
        Method.POST,
        "system/login",
        body: body,
        serializer: (_) => Login.fromJson(_),
        retry: true,
        cacheRequest: true,
      );

  Future<Either<Failure, dynamic>> getClients() => api.request<Client>(
        Method.GET,
        "system/mandanten",
        responseType: ResponseType.LIST,
        serializer: (_) => Client.fromJson(_),
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
        paging: paging,
        searchIn: searchQuery != null
            ? ["vehicle_number", "license_plate", "vin"]
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
    int vehicleId,
    FilePayload file,
  ) =>
      api.request(
        Method.MULTIPART,
        "fleet/vehicles/$vehicleId/images/files",
        retry: true,
        onProgress: (bytes, length) {
          print("BYTES $bytes - LENGTH: $length");
        },
        file: file,
        cacheRequest: true,
      );
}
