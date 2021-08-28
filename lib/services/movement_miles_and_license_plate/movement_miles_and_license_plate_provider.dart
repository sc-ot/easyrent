import 'package:camera/camera.dart';
import 'package:easyrent/core/constants.dart';
import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/models/camera.dart';
import 'package:easyrent/services/camera/camera_page.dart';
import 'package:flutter/cupertino.dart';

class MovementMilesAndLicensePlateProvider extends StateProvider {
  PageController pageController = PageController();

  int currentPage = 0;
  XFile? drivingLicense;
  XFile? drivingLicenseBack;

  void pageChanged(int index) {
    currentPage = index;
    setState(state: STATE.SUCCESS);
  }

  void takePicture(BuildContext context) async {
    switch (currentPage) {
      case 1:
        List<XFile> images = await Navigator.pushNamed(
          context,
          Constants.ROUTE_CAMERA,
          arguments: Camera(CameraType.MOVEMENT, ["Führerschein"], null, null),
        ) as List<XFile>;
        print("");
        break;
      case 2:
        break;
    }
  }
}
