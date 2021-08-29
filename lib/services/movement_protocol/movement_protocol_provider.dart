import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/models/inspection_report.dart';
import 'package:flutter/cupertino.dart';

class MovementProtocolProvider extends StateProvider {

  late InspectionReport inspectionReport;

  MovementProtocolProvider(this.inspectionReport);

}
