import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/models/vehicle_image.dart';
import 'package:easyrent/network/repository.dart';

class VehicleInfoProvider extends StateProvider {
  EasyRentRepository easyRentRepository = EasyRentRepository();

  List<VehicleImage> vehicleImages = [];

  VehicleInfoProvider(int vehicleId) {
    getImages(vehicleId);
  }

  void getImages(int vehicleId) {
    
    easyRentRepository.getImageForVehicle(vehicleId).asStream().listen(
      (response) {
        response.fold(
          (error) {
            setState(state: STATE.ERROR);
          },
          (response) {
            vehicleImages = List<VehicleImage>.from(response);
            for(var vehicleImage in vehicleImages){
              vehicleImage.imageUrl = easyRentRepository.api.baseUrl + "/fleet/vehicles/$vehicleId/images/${vehicleImage.id}/file";
            }
            setState(state: STATE.SUCCESS);
          },
        );
      },
    );
  }
}
