import 'package:camera/camera.dart';

class CameraPicture {
  XFile? image;
  String tag;
  bool showInGalery;
  String assetName;
  String base64;
  CameraPicture(this.image, this.tag, this.showInGalery, this.assetName, this.base64);


}
