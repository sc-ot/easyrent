import 'package:camera/camera.dart';
import 'package:easyrent/models/camera_image.dart';
import 'package:flutter/cupertino.dart';

class CameraProvider with ChangeNotifier, WidgetsBindingObserver {
  CameraController? cameraController;
  PageController pageController = PageController();
  List<CameraDescription> cameras = [];
  List<CameraPicture> images = [];

  double _currentScale = 1.0;
  double _baseScale = 1.0;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 10.0;
  int pointers = 0;

  late Future initCameraFuture;

  int mandatoryImages = 0;
  int get mandatoryImagesTaken {
    int imageTakenCounter = 0;
    for (int i = 0; i < mandatoryImages; i++) {
      imageTakenCounter =
          images[i].image != null ? imageTakenCounter + 1 : imageTakenCounter;
    }
    return imageTakenCounter;
  }

  int get currentImageIndex {
    for (int i = 0; i < images.length; i++) {
      if (images[i].image == null) {
        return i;
      }
    }
    return images.length - 1;
  }

  bool initialising = true;
  bool takingPicturefinished = true;

  CameraProvider({this.images = const []}) {
    WidgetsBinding.instance!.addObserver(this);

    mandatoryImages = images.length;
    initCameraFuture = initCamera();
  }

  Future<void> initCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.max);
    await cameraController!.initialize();
  }

  void handleScaleStart(ScaleStartDetails details) {
    _baseScale = _currentScale;
  }

  Future<void> handleScaleUpdate(ScaleUpdateDetails details) async {
    if (cameraController == null || pointers != 2) {
      return;
    }
    _currentScale = (_baseScale * details.scale)
        .clamp(_minAvailableZoom, _maxAvailableZoom);
    print(_currentScale);
    await cameraController!.setZoomLevel(_currentScale);
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (cameraController == null) {
      return;
    }

    final offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    cameraController!.setExposurePoint(offset);
    cameraController!.setFocusPoint(offset);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    cameraController?.dispose();
    super.dispose();
  }

  Future<void> resetCamera(CameraDescription cameraDescription) async {
    initialising = true;
    if (cameraController != null) {
      await cameraController!.dispose();
    }
    cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
    );
    await cameraController!.initialize();
    initialising = false;
    notifyListeners();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (initialising) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (cameraController != null) {
        resetCamera(cameraController!.description);
      }
    }
  }

  void takePicture() {
    if (takingPicturefinished) {
      takingPicturefinished = false;
      cameraController!.takePicture().then(
        (XFile? file) {
          int currentIndex = currentImageIndex;
          images[currentImageIndex].image = file;
          if (currentIndex == images.length - 1) {
            images.add(
              CameraPicture(
                  null,
                  "Optionales Bild " +
                      (images.length + 1 - mandatoryImages).toString(),
                  true,
                  ""),
            );
          }

          takingPicturefinished = true;
          notifyListeners();
        },
      );
    }
  }

  bool isOptionalImage() => currentImageIndex < mandatoryImages - 1;

  void deletePicture(int index) {
    // Wenn es ein optionales Bild ist
    if (index > mandatoryImages - 1) {
      images.removeAt(index);
      int optionalImage = 1;
      for (int i = mandatoryImages; i < images.length; i++, optionalImage++) {
        images[i].tag = "Optionales Bild " + optionalImage.toString();
      }
    } else {
      images[index].image = null;
    }
    notifyListeners();
  }

  bool allMandatoryImagesTaken() => mandatoryImagesTaken == mandatoryImages;

  bool takeOptionalImagesNow() => images.length > mandatoryImages;
}
