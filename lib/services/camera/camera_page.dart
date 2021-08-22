import 'dart:io';

import 'package:camera/camera.dart';
import 'package:easyrent/models/camera.dart';
import 'package:easyrent/services/camera/camera_provider.dart';
import 'package:easyrent/widgets/menu_page_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class CameraPage extends StatelessWidget {
  CameraPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    Camera camera = args as Camera;
    return ChangeNotifierProvider(
      create: (BuildContext context) => CameraProvider(camera),
      builder: (context, child) {
        CameraProvider cameraProvider =
            Provider.of<CameraProvider>(context, listen: true);

        return WillPopScope(
          onWillPop: () {
            cameraProvider.uploadImages();
            return Future.value(true);
          },
          child: Scaffold(
            body: SafeArea(
              child: FutureBuilder<void>(
                future: cameraProvider.initCameraFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    logImages(cameraProvider);
                    final size = MediaQuery.of(context).size;

                    var scale = size.aspectRatio *
                        cameraProvider.cameraController!.value.aspectRatio;
                    if (scale < 1) scale = 1 / scale;
                    return NotificationListener<
                        OverscrollIndicatorNotification>(
                      onNotification: (overscroll) {
                        overscroll.disallowGlow();
                        return true;
                      },
                      child: PageView(
                        controller: cameraProvider.pageController,
                        children: [
                          Stack(
                            children: [
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  return Listener(
                                    onPointerDown: (_) =>
                                        cameraProvider.pointers++,
                                    onPointerUp: (_) =>
                                        cameraProvider.pointers--,
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onScaleStart:
                                          cameraProvider.handleScaleStart,
                                      onScaleUpdate:
                                          cameraProvider.handleScaleUpdate,
                                      onTapDown: (details) =>
                                          cameraProvider.onViewFinderTap(
                                              details, constraints),
                                      child: Transform.scale(
                                        scale: scale,
                                        child: Center(
                                          child: CameraPreview(
                                              cameraProvider.cameraController!),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey.withOpacity(0.4),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        cameraProvider
                                            .images[cameraProvider
                                                .currentImageIndex]
                                            .tag,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4!
                                            .copyWith(color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey.withOpacity(0.2),
                                    ),
                                    height: 100,
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Align(
                                            alignment: Alignment.bottomLeft,
                                            child: RawMaterialButton(
                                              onPressed: () {
                                                cameraProvider.pageController
                                                    .nextPage(
                                                        duration: Duration(
                                                            milliseconds: 500),
                                                        curve: Curves.easeIn);
                                              },
                                              fillColor:
                                                  Colors.grey.withOpacity(0.05),
                                              child: Icon(
                                                Icons.image_search_outlined,
                                                size: 35.0,
                                                color: Colors.white,
                                              ),
                                              padding: EdgeInsets.all(15.0),
                                              shape: CircleBorder(),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: RawMaterialButton(
                                              onPressed: () {
                                                cameraProvider.takePicture();
                                              },
                                              fillColor:
                                                  Colors.grey.withOpacity(0.05),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    LineIcons.camera,
                                                    size: 35.0,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                    (cameraProvider
                                                                .mandatoryImagesTaken)
                                                            .toString() +
                                                        " / " +
                                                        cameraProvider
                                                            .mandatoryImages
                                                            .toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .button,
                                                  )
                                                ],
                                              ),
                                              shape: CircleBorder(),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: RawMaterialButton(
                                              onPressed: () {
                                                cameraProvider
                                                    .closeCamera(context);
                                              },
                                              fillColor:
                                                  Colors.grey.withOpacity(0.05),
                                              child: Icon(
                                                LineIcons.times,
                                                size: 35.0,
                                                color: Colors.white,
                                              ),
                                              padding: EdgeInsets.all(15.0),
                                              shape: CircleBorder(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          MenuPageContainer(
                            "Fotos",
                            "Aufgenommene Fotos",
                            cameraProvider.images.length == 0
                                ? Container()
                                : GridView.count(
                                    cacheExtent: 250,
                                    shrinkWrap: true,
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 16,
                                    children: List.generate(
                                      cameraProvider.takeOptionalImagesNow()
                                          ? cameraProvider.images.length - 1
                                          : cameraProvider.images.length,
                                      (index) {
                                        return cameraProvider
                                                .images[index].showInGalery
                                            ? Card(
                                                elevation: 7,
                                                semanticContainer: true,
                                                clipBehavior: Clip.hardEdge,
                                                child: Stack(
                                                  fit: StackFit.expand,
                                                  children: [
                                                    cameraProvider.images[index]
                                                                .image !=
                                                            null
                                                        ? FullScreenWidget(
                                                            disposeLevel:
                                                                DisposeLevel
                                                                    .High,
                                                            child: Hero(
                                                              tag: "fullScreenImage" +
                                                                  index
                                                                      .toString(),
                                                              child: Image.file(
                                                                File(cameraProvider
                                                                    .images[
                                                                        index]
                                                                    .image!
                                                                    .path),
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          )
                                                        : Container(),
                                                    cameraProvider.images[index]
                                                                .image ==
                                                            null
                                                        ? Center(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                    cameraProvider
                                                                        .images[
                                                                            index]
                                                                        .tag,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .headline6,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          16.0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .image_not_supported,
                                                                    size: 50,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        : Container(),
                                                    cameraProvider.images[index]
                                                                .image !=
                                                            null
                                                        ? Align(
                                                            alignment: Alignment
                                                                .bottomCenter,
                                                            child: Container(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColorLight
                                                                  .withOpacity(
                                                                      0.5),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .all(
                                                                          16.0),
                                                                      child:
                                                                          Text(
                                                                        cameraProvider
                                                                            .images[index]
                                                                            .tag,
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .headline6!
                                                                            .copyWith(fontSize: MediaQuery.of(context).size.height * 0.022),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        maxLines:
                                                                            1,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      cameraProvider
                                                                          .deletePicture(
                                                                              index);
                                                                    },
                                                                    icon: Icon(
                                                                        Icons
                                                                            .delete_outline_outlined,
                                                                        size:
                                                                            30),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        : Container(),
                                                  ],
                                                ),
                                              )
                                            : Container();
                                      },
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void logImages(CameraProvider cameraProvider) {
    print("--");
    print(
        "Aktuelles Bild: " + (cameraProvider.currentImageIndex + 1).toString());
    print("Bilderanzahl: " + cameraProvider.images.length.toString());
    print("Pflichtbilder gemacht: " +
        cameraProvider.mandatoryImagesTaken.toString());
    print("--");
  }
}

enum CameraType {
  MOVEMENT,
  ACCIDENT_VEHICLE,
  NEW_VEHICLE,
  VEHICLE,
}
