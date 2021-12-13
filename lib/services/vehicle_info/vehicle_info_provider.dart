import 'dart:async';

import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/models/vehicle.dart';
import 'package:easyrent/models/vehicle_image.dart';
import 'package:easyrent/network/repository.dart';
import 'package:flutter/cupertino.dart';

class VehicleInfoProvider extends StateProvider {
  EasyRentRepository easyRentRepository = EasyRentRepository();
  ScrollController scrollController = ScrollController();
  StreamSubscription? imageForVehicleSubscription;
  StreamSubscription? vehicleSubscription;
  bool imagesLoaded = false;
  bool vehicleLoaded = false;

  List<VehicleImage> vehicleImages = [];
  late int vehicleId;
  late Vehicle vehicle;
  VehicleInfoProvider(int vehicleId) {
    this.vehicleId = vehicleId;
    getVehicle();
    getImages();
  }

  void getVehicle() {
    vehicleSubscription?.cancel();
    vehicleSubscription =
        easyRentRepository.getVehicle(vehicleId).asStream().listen(
      (response) {
        response.fold(
          (error) => null,
          (result) {
            vehicle = result as Vehicle;
            vehicleLoaded = true;
            if (imagesLoaded && vehicleLoaded) {
              setState(state: STATE.SUCCESS);
            }
          },
        );
      },
    );
  }

  void getImages() {
    imageForVehicleSubscription?.cancel();
    imageForVehicleSubscription =
        easyRentRepository.getImageForVehicle(vehicleId).asStream().listen(
      (response) {
        response.fold(
          (error) {
            setState(state: STATE.ERROR);
            WidgetsBinding.instance?.addPostFrameCallback(
              (_) {
                scrollController.animateTo(100,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn);
              },
            );
          },
          (response) {
            vehicleImages = List<VehicleImage>.from(response);
            for (var vehicleImage in vehicleImages) {
              vehicleImage.imageUrl = easyRentRepository.api.baseUrl +
                  "/fleet/vehicles/$vehicleId/images/${vehicleImage.id}/file";
            }
            imagesLoaded = true;
            if (imagesLoaded && vehicleLoaded) {
              setState(state: STATE.SUCCESS);
              if (vehicleImages.length == 0) {
                WidgetsBinding.instance?.addPostFrameCallback(
                  (_) {
                    scrollController.animateTo(100,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  },
                );
              }
            }
          },
        );
      },
    );
  }
}
