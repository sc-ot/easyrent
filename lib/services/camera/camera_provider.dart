import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:devtools/models/file_payload.dart';
import 'package:devtools/sc_shared_prefs_storage.dart';
import 'package:easyrent/core/application.dart';
import 'package:easyrent/core/constants.dart';
import 'package:easyrent/core/utils.dart';
import 'package:easyrent/main.dart';
import 'package:easyrent/models/camera.dart';
import 'package:easyrent/models/camera_picture.dart';
import 'package:easyrent/models/fleet_vehicle_image_upload_process.dart';
import 'package:easyrent/models/image_history.dart';
import 'package:easyrent/network/repository.dart';
import 'package:exif/exif.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:image/image.dart' as img;

import 'camera_page.dart';

class CameraProvider with ChangeNotifier, WidgetsBindingObserver {
  EasyRentRepository easyRentRepository = EasyRentRepository();
  CameraController? cameraController;
  PageController pageController = PageController();
  List<CameraDescription> cameras = [];
  List<CameraPicture> images = [];
  late Camera camera;
  late NativeDeviceOrientation currentOrientation;

  double _currentScale = 1.0;
  double _baseScale = 1.0;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 10.0;
  int pointers = 0;

  late Future initCameraFuture;
  bool showPreviewImage = false;
  File? previewImage;
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
    if (images.length == 0) {
      return 0;
    }
    return images.length - 1;
  }

  bool initialising = true;
  bool takingPicturefinished = true;

  CameraProvider(Camera camera) {
    this.camera = camera;
    WidgetsBinding.instance!.addObserver(this);

    for (var tag in camera.tags) {
      images.add(
        CameraPicture(null, tag, true, "", ""),
      );
    }

    if (images.length == 0) {
      images.add(
        CameraPicture(null, "Optionales Bild 1", true, "", ""),
      );
    }

    mandatoryImages = camera.tags.length;
    initCameraFuture = initCamera();
  }

  void setOrientation(NativeDeviceOrientation orientation) {
    currentOrientation = orientation;
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

  Future<File> fixExifRotation(String imagePath) async {
    final originalFile = File(imagePath);
    List<int> imageBytes = await originalFile.readAsBytes();

    final originalImage = img.decodeImage(imageBytes);

    final height = originalImage!.height;
    final width = originalImage.width;

    // Let's check for the image size
    if (height >= width) {
      // I'm interested in portrait photos so
      // I'll just return here
      return originalFile;
    }

    // We'll use the exif package to read exif data
    // This is map of several exif properties
    // Let's check 'Image Orientation'
    final exifData = await readExifFromBytes(imageBytes);

    img.Image? fixedImage;

    if (height < width) {
      print('Rotating image necessary');
      // rotate
      if (exifData['Image Orientation']!.printable.contains('Horizontal')) {
        fixedImage = img.copyRotate(originalImage, 90);
      } else if (exifData['Image Orientation']!.printable.contains('180')) {
        fixedImage = img.copyRotate(originalImage, -90);
      } else {
        fixedImage = img.copyRotate(originalImage, 0);
      }
    }

    // Here you can select whether you'd like to save it as png
    // or jpg with some compression
    // I choose jpg with 100% quality
    final fixedFile =
        await originalFile.writeAsBytes(img.encodeJpg(fixedImage!));

    return fixedFile;
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
          (XFile? file) async {
            int currentIndex = currentImageIndex;
            images[currentImageIndex].image = file;
            images[currentImageIndex].base64 = "data:image/jpg;base64," +
                base64Encode(await file!.readAsBytes());

            // Nur 1 Foto erlaubt
            if (camera.singleImage) {
              closeCamera(context);
              return;
            }

            if (currentIndex == images.length - 1) {
              images.add(
                CameraPicture(
                    null,
                    "Optionales Bild " +
                        (images.length + 1 - mandatoryImages).toString(),
                    true,
                    "",
                    ""),
              );
            }
            previewImage = File(file.path);
            showPreviewImage = true;
            takingPicturefinished = true;
            await cameraController!
                .lockCaptureOrientation(DeviceOrientation.portraitUp);
            notifyListeners();
            Future.delayed(
              Duration(seconds: 2),
              () {
                showPreviewImage = false;
                notifyListeners();
              },
            );
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
    int successUploadedImages = 0;
    List<CameraPicture> images = imagesToUpload();

    if (images.length > 0) {
      List<String> imagePaths = images.map((e) => e.image!.path).toList();
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
      }
    }

    easyRentRepository.getImageUploadProcess().asStream().listen(
      (response) {
        response.fold(
          (failure) => null,
          (response) {
            FleetVehicleImageUploadProccess uploadProccess =
                response as FleetVehicleImageUploadProccess;

            switch (camera.type) {
              case CameraType.VEHICLE:
                for (var image in images) {
                  easyRentRepository
                      .uploadImage(
                        camera.vehicle!.id,
                        FilePayload(
                          File(image.image!.path),
                          {
                            "tag": image.tag,
                            "upload_process": uploadProccess.id.toString(),
                            "is_favorite": image.tag == "Frontal-Links" ||
                                    image.tag == "Heck-Rechts"
                                ? "1"
                                : "0",
                          },
                        ),
                      )
                      .asStream()
                      .listen(
                    (response) {
                      response.fold(
                        (l) {},
                        (r) {
                          successUploadedImages++;
                          if (successUploadedImages == images.length) {
                            String titleText = camera.vehicle == null
                                ? "Fahrzeug: " + camera.vin!
                                : camera.vehicle!.letterNumber +
                                    " - " +
                                    camera.vehicle!.licensePlate;
                            showSimpleNotification(
                              Text(
                                titleText,
                                style: Theme.of(navigatorKey.currentContext!)
                                    .textTheme
                                    .subtitle1,
                              ),
                              subtitle: Text(
                                "${images.length} Bilder hochgeladen",
                                style: Theme.of(navigatorKey.currentContext!)
                                    .textTheme
                                    .subtitle2,
                              ),
                              background: Theme.of(navigatorKey.currentContext!)
                                  .primaryColor,
                              duration: Duration(seconds: 3),
                              slideDismissDirection: DismissDirection.vertical,
                              leading: Icon(
                                Icons.done,
                                color: Colors.green,
                              ),
                            );
                          }
                        },
                      );
                    },
                  );
                }
                break;
              case CameraType.NEW_VEHICLE:
                for (var image in images) {
                  easyRentRepository.uploadImage(
                    0,
                    FilePayload(
                      File(image.image!.path),
                      {
                        "tag": image.tag,
                        "vin": camera.vin!,
                      },
                    ),
                  );
                  break;
                }
            }
          },
        );
      },
    );
  }

  bool allMandatoryImagesTaken() => mandatoryImagesTaken == mandatoryImages;

  bool takeOptionalImagesNow() => images.length > mandatoryImages;
}
