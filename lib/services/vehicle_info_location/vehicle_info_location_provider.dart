import 'dart:async';

import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/models/vehicle.dart';
import 'package:easyrent/network/repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class VehicleInfoLocationProvider extends StateProvider {
  EasyRentRepository easyRentRepository = EasyRentRepository();
  Completer<GoogleMapController> controller = Completer();

  LatLng? vehiclePosition;
  LatLng? currentUserPosition;
  late Vehicle vehicle;
  VehicleInfoLocationProvider(Vehicle vehicle) {
    this.vehicle = vehicle;
    // wait for google Maps init
    controller.future.asStream().listen(
      (controller) {
        getCurrentPosition();
      },
    );
  }

  void getCurrentPosition() {}
}
