import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/models/movement.dart';
import 'package:easyrent/models/vehicle.dart';
import 'package:easyrent/network/repository.dart';

class VehicleInfoEquipmentsProvider extends StateProvider {
  EasyRentRepository easyRentRepository = EasyRentRepository();

  List<Movement> movements = [];
  late Vehicle vehicle;
  VehicleInfoEquipmentsProvider(Vehicle vehicle) {
    this.vehicle = vehicle;
    getMovements(vehicle.id);
  }

  void getMovements(int vehicleId) {
    easyRentRepository.getMovementsForVehicle(vehicleId).asStream().listen(
      (response) {
        response.fold(
          (error) {
            setState(state: STATE.ERROR);
          },
          (response) {
            movements = List<Movement>.from(response);
            setState(state: STATE.SUCCESS);
          },
        );
      },
    );
  }
}
