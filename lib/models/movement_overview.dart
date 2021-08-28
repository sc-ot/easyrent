import 'package:easyrent/models/movement.dart';
import 'package:easyrent/models/planned_movement.dart';
import 'package:easyrent/models/vehicle.dart';

class MovementOverview {
  int movementType;
  Vehicle? vehicle;
  PlannedMovement? plannedMovement;

  MovementOverview(this.movementType, this.vehicle, this.plannedMovement);
}
