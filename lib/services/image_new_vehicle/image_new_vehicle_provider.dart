import 'package:easyrent/core/constants.dart';
import 'package:easyrent/core/state_provider.dart';
import 'package:flutter/cupertino.dart';

class ImagesNewVehicleProvider extends StateProvider {
  TextEditingController vinTextEditingController = TextEditingController();

  ImagesNewVehicleProvider();
  void checkValue() {
    if (vinTextEditingController.text.length == Constants.VIN_MAX_LENGTH) {
      setState(state: STATE.SUCCESS);
    } else {
      setState(state: STATE.IDLE);
    }
  }
}
