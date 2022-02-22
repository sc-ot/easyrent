import 'package:camera/camera.dart';
import 'package:easyrent/core/constants.dart';
import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/models/camera.dart';
import 'package:easyrent/models/camera_picture.dart';
import 'package:easyrent/models/inspection_report.dart';
import 'package:easyrent/services/camera/camera_page.dart';
import 'package:flutter/cupertino.dart';

class MovementProtocolDrivingLicenseProvider extends StateProvider {
  PageController pageController = PageController();
  late InspectionReport inspectionReport;
  int currentPage = 0;
  XFile? drivingLicense;
  XFile? drivingLicenseBack;

  void pageChanged(int index) {
    currentPage = index;
    setState(state: STATE.SUCCESS);
  }

  void takePicture(bool isDrivingLicenseBack, BuildContext context) async {
    String tag =
        isDrivingLicenseBack ? "Führerschein Rückseite" : "Führerschein";

    List<CameraPicture> image = await Navigator.pushNamed(
      context,
      Constants.ROUTE_CAMERA,
      arguments:
          Camera(CameraType.MOVEMENT, [tag], null, null, singleImage: true),
    ) as List<CameraPicture>;

    if (image.isNotEmpty) {
      if (!isDrivingLicenseBack) {
        drivingLicense = image[0].image;
        inspectionReport.drivingLicense = image[0].base64;
      } else {
        drivingLicenseBack = image[0].image;
        inspectionReport.drivingLicenseBack = image[0].base64;
      }
      setState(state: STATE.SUCCESS);
    }
  }

  void deleteImage(bool isDrivingLicenseBack) {
    if (!isDrivingLicenseBack) {
      drivingLicense = null;
    } else {
      drivingLicenseBack = null;
    }
    notifyListeners();
  }
}
