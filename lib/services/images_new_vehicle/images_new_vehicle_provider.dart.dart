import 'package:easyrent/core/state_provider.dart';
import 'package:flutter/cupertino.dart';

class ImagesNewVehicleProvider extends StateProvider{


  TextEditingController vinTextEditingController = TextEditingController();

  ImagesNewVehicleProvider();

  void checkValue(){
    if(vinTextEditingController.text.length == 16){
      setState(state: STATE.SUCCESS);
    }
    else{
      setState(state: STATE.IDLE);
    }
  }

}