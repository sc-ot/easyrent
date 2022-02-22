import 'package:camera/camera.dart';
import 'package:easyrent/core/constants.dart';
import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/models/camera.dart';
import 'package:easyrent/models/camera_picture.dart';
import 'package:easyrent/models/inspection_report.dart';
import 'package:easyrent/services/camera/camera_page.dart';
import 'package:flutter/cupertino.dart';

class MovementProtocolDisplayProvider extends StateProvider {
  PageController pageController = PageController();
  late InspectionReport inspectionReport;
  XFile? display;

  void takePicture(BuildContext context) async {
    String tag = "Display";

    List<CameraPicture> image = await Navigator.pushNamed(
      context,
      Constants.ROUTE_CAMERA,
      arguments:
          Camera(CameraType.MOVEMENT, [tag], null, null, singleImage: true),
    ) as List<CameraPicture>;

    if (image.isNotEmpty) {
      display = image[0].image;
      inspectionReport.screen = image[0].base64;

      setState(state: STATE.SUCCESS);
    }
  }

  void deleteImage() {
    display = null;
    notifyListeners();
  }
}
