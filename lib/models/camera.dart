import 'package:easyrent/models/vehicle.dart';
import 'package:easyrent/services/camera/camera_page.dart';

class Camera {
  CameraType type;
  List<String> tags;
  Vehicle? vehicle;
  String? vin;
  bool singleImage;
  Camera(this.type, this.tags, this.vehicle, this.vin,
      {this.singleImage = false});
}
