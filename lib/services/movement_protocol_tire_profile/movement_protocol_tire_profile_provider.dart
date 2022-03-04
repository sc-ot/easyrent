import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/models/axis.dart';
import 'package:easyrent/models/inspection_report.dart';
import 'package:easyrent/models/vehicle_axis_profile.dart';

import '../../models/wheel.dart';

class MovementProtocolTireProfileProvider extends StateProvider {
  late InspectionReport inspectionReport;
  late AxisProfile vehicleAxisProfile;

  MovementProtocolTireProfileProvider(InspectionReport inspectionReport) {
    this.inspectionReport = inspectionReport;
  }

  void deleteAxis(int axisIndex) {
    this.inspectionReport.vehicle?.axisProfile?.axis.removeAt(axisIndex);
    setState(state: STATE.SUCCESS);
  }

  void addTire(int axisIndex) {
    this.inspectionReport.vehicle?.axisProfile?.axis[axisIndex].wheelsLeft.add(
          Wheel(0, "", "", null, 0),
        );
    this.inspectionReport.vehicle?.axisProfile?.axis[axisIndex].wheelsRight.add(
          Wheel(0, "", "", null, 0),
        );
    setState(state: STATE.SUCCESS);
  }

  void removeTire(int axisIndex) {
    this
        .inspectionReport
        .vehicle
        ?.axisProfile
        ?.axis[axisIndex]
        .wheelsLeft
        .removeAt(0);
    this
        .inspectionReport
        .vehicle
        ?.axisProfile
        ?.axis[axisIndex]
        .wheelsRight
        .removeAt(0);
    setState(state: STATE.SUCCESS);
  }
}
