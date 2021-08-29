import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/models/inspection_report.dart';
import 'package:flutter/cupertino.dart';

class MovementLicensPlateAndMilesProvider extends StateProvider {
  PageController pageController = PageController();
  late InspectionReport inspectionReport;
  
  TextEditingController textEditingControllerLicensePlate =
      TextEditingController();
  TextEditingController textEditingControllerMiles = TextEditingController();

  bool milesOkay = false;

  MovementLicensPlateAndMilesProvider(InspectionReport inspectionReport){
    this.inspectionReport = inspectionReport;
    textEditingControllerLicensePlate.text = inspectionReport.vehicle!.licensePlate;
  }


  void milesChanged(String miles){
    int? milesParsed = int.tryParse(miles);
    if(milesParsed != null){
      inspectionReport.licensePlate = textEditingControllerLicensePlate.text;
      inspectionReport.currentMilleage = milesParsed;
      milesOkay = true;
      setState(state: STATE.SUCCESS);
    }
    else{
      setState(state: STATE.ERROR);
    }
  }


}
