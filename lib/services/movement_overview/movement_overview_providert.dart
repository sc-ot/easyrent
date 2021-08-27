import 'dart:async';

import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/models/planned_movement.dart';
import 'package:easyrent/models/vehicle.dart';
import 'package:easyrent/network/repository.dart';

class MovementOverviewProvider extends StateProvider {

  StreamSubscription? movementProtocolSubscription;
  PlannedMovement? plannedMovement;
  Vehicle? vehicle;
  EasyRentRepository easyRentRepository = EasyRentRepository();
  MovementOverviewProvider({this.vehicle, this.plannedMovement});

  void generateInspectionReport() {}
}
