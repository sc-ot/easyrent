import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/models/vehicle.dart';
import 'package:easyrent/models/vehicle_image.dart';
import 'package:easyrent/network/repository.dart';
import 'package:flutter/cupertino.dart';

class VehicleInfoProvider extends StateProvider {
  EasyRentRepository easyRentRepository = EasyRentRepository();
  ScrollController scrollController = ScrollController();

  List<VehicleImage> vehicleImages = [];
  late Vehicle vehicle;
  VehicleInfoProvider(Vehicle vehicle) {
    this.vehicle = vehicle;
    getImages(vehicle.id);
  }

  void getImages(int vehicleId) {
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
          },
        );
      },
    );
  }
}
