import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:easyrent/core/application.dart';
import 'package:easyrent/core/authenticator.dart';
import 'package:easyrent/core/constants.dart';
import 'package:easyrent/core/utils.dart';
import 'package:easyrent/main.dart';
import 'package:easyrent/models/camera.dart';
import 'package:easyrent/models/camera_picture.dart';
import 'package:easyrent/models/fleet_vehicle_image_upload_process.dart';
import 'package:easyrent/network/repository.dart';
import 'package:easyrent/services/camera/image_uploader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:sc_appframework/utils/base64_utils.dart';

import 'camera_page.dart';

class CameraProvider with ChangeNotifier, WidgetsBindingObserver {
  EasyRentRepository easyRentRepository = EasyRentRepository();
  CameraController? cameraController;
  PageController pageController = PageController();
  List<CameraDescription> cameras = [];
  List<CameraPicture> images = [];
  late Camera camera;
  late NativeDeviceOrientation currentOrientation;
  FlashMode? currentFlashMode;

  double _currentScale = 1.0;
  double _baseScale = 1.0;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 10.0;
  int pointers = 0;
  String path = "";
  late Future initCameraFuture;
  bool showPreviewImage = false;
  File? previewImage;
  int mandatoryImages = 0;
  bool mounted = true;

  bool initialising = true;
  bool takingPicturefinished = true;

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
    if (images.length == 0) {
      return 0;
    }
    return images.length - 1;
  }

  CameraProvider(Camera camera) {
    this.camera = camera;
    WidgetsBinding.instance!.addObserver(this);

    for (var tag in camera.tags) {
      images.add(
        CameraPicture(null, tag, true, "", "", ""),
      );
    }

    if (images.length == 0) {
      images.add(
        CameraPicture(null, "Optionales Bild 1", true, "", "", ""),
      );
    }

    mandatoryImages = camera.tags.length;
    initCameraFuture = initCamera();
  }

  void setOrientation(NativeDeviceOrientation orientation) {
    currentOrientation = orientation;
  }

  void setFlashMode(FlashMode flashMode) {
    cameraController!.setFlashMode(flashMode);
    currentFlashMode = flashMode;
    notifyListeners();
  }

  Future<void> initCamera() async {
    cameras = await availableCameras();

    cameraController = CameraController(
      cameras[0],
      ResolutionPreset.max,
    );
    await cameraController!.initialize();
    await cameraController!
        .lockCaptureOrientation(DeviceOrientation.portraitUp);
    setFlashMode(FlashMode.off);
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
    mounted = false;
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

  void takePicture(BuildContext context) async {
    if (takingPicturefinished) {
      takingPicturefinished = false;
      notifyListeners();
      if (Platform.isIOS) {
        switch (currentOrientation) {
          case NativeDeviceOrientation.portraitUp:
            await cameraController!
                .lockCaptureOrientation(DeviceOrientation.portraitUp);
            break;
          case NativeDeviceOrientation.portraitDown:
            await cameraController!
                .lockCaptureOrientation(DeviceOrientation.portraitDown);

            break;
          case NativeDeviceOrientation.landscapeLeft:
            await cameraController!
                .lockCaptureOrientation(DeviceOrientation.landscapeRight);
            break;
          case NativeDeviceOrientation.landscapeRight:
            await cameraController!
                .lockCaptureOrientation(DeviceOrientation.landscapeLeft);

            break;
          case NativeDeviceOrientation.unknown:
            await cameraController!
                .lockCaptureOrientation(DeviceOrientation.portraitUp);
            break;
        }
      } else {
        switch (currentOrientation) {
          case NativeDeviceOrientation.portraitUp:
            await cameraController!
                .lockCaptureOrientation(DeviceOrientation.portraitUp);
            break;
          case NativeDeviceOrientation.portraitDown:
            await cameraController!
                .lockCaptureOrientation(DeviceOrientation.portraitDown);

            break;
          case NativeDeviceOrientation.landscapeRight:
            await cameraController!
                .lockCaptureOrientation(DeviceOrientation.landscapeRight);
            break;
          case NativeDeviceOrientation.landscapeLeft:
            await cameraController!
                .lockCaptureOrientation(DeviceOrientation.landscapeLeft);

            break;
          case NativeDeviceOrientation.unknown:
            await cameraController!
                .lockCaptureOrientation(DeviceOrientation.portraitUp);

            break;
        }
      }

      try {
        cameraController!.takePicture().then(
          (XFile? xFile) async {
            if (xFile != null) {
              int currentIndex = currentImageIndex;
              images[currentIndex].image = xFile;

              if (camera.type == CameraType.MOVEMENT) {
                images[currentIndex].base64 = "data:image/jpg;base64," +
                    Base64Utils.base64StringFromData(await xFile.readAsBytes());
              }

              // Nur 1 Foto erlaubt
              if (camera.singleImage) {
                closeCamera(context);
                return;
              }

              // Optionales Bild
              if (currentIndex == images.length - 1) {
                images.add(
                  CameraPicture(
                      null,
                      "Optionales Bild " +
                          (images.length + 1 - mandatoryImages).toString(),
                      true,
                      "",
                      "",
                      ""),
                );
              }

              // Preview Image setzen + Blackscreen
              previewImage = File(xFile.path);
              showPreviewImage = true;
              takingPicturefinished = true;
              await cameraController!
                  .lockCaptureOrientation(DeviceOrientation.portraitUp);
              if (mounted) {
                notifyListeners();
              }
              Future.delayed(
                Duration(seconds: 2),
                () {
                  showPreviewImage = false;
                  if (mounted) {
                    notifyListeners();
                  }
                },
              );
            }
          },
        );
      } catch (e) {
        await cameraController!
            .lockCaptureOrientation(DeviceOrientation.portraitUp);
        takingPicturefinished = true;
        notifyListeners();
      }
    }
  }

  bool isOptionalImage() => currentImageIndex < mandatoryImages - 1;

  void deletePicture(int index) {
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

  void closeCamera(BuildContext context) {
    String bodyText =
        "Es wurden nicht alle Pflichtfotos aufgenommen. Möchten Sie den Vorgang abschließen?";
    String titleText = "Fehlende Fotos";
    String actionText = "Hochladen";

    if (allMandatoryImagesTaken()) {
      titleText = "Fotos hochladen";
      bodyText = "Möchten Sie den Vorgang abschließen?";
    }

    if (imagesToUpload().length == 0) {
      actionText = "Beenden";
      if (camera.singleImage) {
        Navigator.pop(
          context,
          imagesToUpload(),
        );
        return;
      }
    }

    switch (camera.type) {
      case CameraType.MOVEMENT:
        Navigator.pop(
          context,
          imagesToUpload(),
        );

        break;
      default:
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Abbrechen",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    uploadImages(context);
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Constants.ROUTE_MENU,
                      (route) {
                        return false;
                      },
                    );
                  },
                  child: Text(
                    actionText,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                )
              ],
              backgroundColor: Theme.of(context).primaryColor,
              title: Text(
                titleText,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
              content: Text(
                bodyText,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            );
          },
        );
    }
  }

  List<CameraPicture> imagesToUpload() {
    return List.from(
      images.where(
        (element) => element.image != null,
      ),
    );
  }

  void uploadImages(BuildContext context) async {
    List<CameraPicture> images = imagesToUpload();

    if (images.length > 0) {
      // Maybe overflow in SharedPrefStorage on iOS?
      // Get image paths
      /*   List<String> imagePaths = images.map((e) => e.image!.path).toList();

   
     ImageHistory imageHistory = ImageHistory(
        Provider.of<Application>(context, listen: false).client.name,
        imagePaths,
        Utils.formatDateTimestringWithTime(DateTime.now().toIso8601String()),
        camera.vehicle,
        camera.vin,
      );

      


      
      dynamic historyInPref;

      String? history = SCSharedPrefStorage.readString(Constants.KEY_IMAGES);
     if (history != null) {
        historyInPref = jsonDecode(history);
        historyInPref.add(imageHistory);
        SCSharedPrefStorage.saveData(
          Constants.KEY_IMAGES,
          jsonEncode(
            historyInPref,
          ),
        );
      } else {
        SCSharedPrefStorage.saveData(
          Constants.KEY_IMAGES,
          jsonEncode(
            [imageHistory],
          ),
        );
      }*/

      Application application =
          Provider.of<Application>(context, listen: false);

      easyRentRepository.getImageUploadProcess(images.length).asStream().listen(
        (response) {
          response.fold(
            (failure) => null,
            (response) async {
              FleetVehicleImageUploadProccess uploadProccess =
                  response as FleetVehicleImageUploadProccess;
              Map<String, String> keys = {};
              int vehicleId = 0;
              String newPath = "";
              path = await Utils.createFolderInAppDocDir(
                  "images/${uploadProccess.id}");

              for (var image in images) {
                switch (camera.type) {
                  case CameraType.VEHICLE:
                    vehicleId = camera.vehicle!.id;
                    keys = {
                      "client": Authenticator.getUsername(),
                      "images_count": images.length.toString(),
                      "created_at": DateTime.now().toIso8601String(),
                      "vehicle_number": camera.vehicle!.vehicleNumber,
                      "vin": camera.vehicle!.vin,
                      "tag": image.tag,
                      "upload_process": uploadProccess.id.toString(),
                      "is_favorite": image.tag == "Frontal-Links" ||
                              image.tag == "Heck-Rechts"
                          ? "1"
                          : "0",
                    };

                    break;
                  case CameraType.NEW_VEHICLE:
                    vehicleId = 0;
                    {
                      keys = {
                        "client": Authenticator.getUsername(),
                        "images_count": images.length.toString(),
                        "created_at": DateTime.now().toIso8601String(),
                        "vin": camera.vin!,
                        "upload_process": uploadProccess.id.toString(),
                        "tag": image.tag,
                        "is_favorite": image.tag == "Frontal-Links" ||
                                image.tag == "Heck-Rechts"
                            ? "1"
                            : "0",
                      };

                      break;
                    }
                  default:
                }

                newPath = path +
                    DateTime.now().millisecondsSinceEpoch.toString() +
                    Constants.FILE_NAME_DELIMITER +
                    vehicleId.toString() +
                    Constants.FILE_NAME_DELIMITER +
                    image.tag +
                    Constants.FILE_NAME_DELIMITER +
                    uploadProccess.id.toString() +
                    Constants.FILE_NAME_DELIMITER +
                    "${camera.vin ?? camera.vehicle!.vin}" +
                    Constants.FILE_NAME_DELIMITER +
                    Authenticator.getUsername() +
                    Constants.FILE_NAME_DELIMITER +
                    "${keys["vehicle_number"] ?? ""}" +
                    Constants.FILE_NAME_DELIMITER +
                    application.client.id.toString() +
                    Constants.FILE_NAME_DELIMITER +
                    ".jpg";

                await image.image!.saveTo(newPath);
              }
              ImageUploader.uploadImageForImageGroup(
                  uploadProccess.id, application.clients);
            },
          );
        },
      );
    }
  }

  void showSuccessNotification(List<CameraPicture> images) {
    String titleText = camera.vehicle == null
        ? "Fahrzeug: " + camera.vin!
        : camera.vehicle!.letterNumber + " - " + camera.vehicle!.licensePlate;
    showSimpleNotification(
      Text(
        titleText,
        style: Theme.of(navigatorKey.currentContext!).textTheme.subtitle1,
      ),
      subtitle: Text(
        "${images.length} Bilder hochgeladen",
        style: Theme.of(navigatorKey.currentContext!).textTheme.subtitle2,
      ),
      background: Theme.of(navigatorKey.currentContext!).primaryColor,
      duration: Duration(seconds: 3),
      slideDismissDirection: DismissDirection.vertical,
      leading: Icon(
        Icons.done,
        color: Colors.green,
      ),
    );
  }

  bool allMandatoryImagesTaken() => mandatoryImagesTaken == mandatoryImages;

  bool takeOptionalImagesNow() => images.length > mandatoryImages;
}
