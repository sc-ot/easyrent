import 'dart:io';

import 'package:easyrent/core/constants.dart';
import 'package:easyrent/models/inspection_report.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../widgets/menu_page_container_widget.dart';
import 'movement_driving_license_provider.dart';

class MovementDrivingLicensePage extends StatelessWidget {
  const MovementDrivingLicensePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    InspectionReport inspectionReport = args as InspectionReport;
    return ChangeNotifierProvider<MovementDrivingLicenseProvider>(
      create: (context) => MovementDrivingLicenseProvider(),
      builder: (context, child) {
        MovementDrivingLicenseProvider movementDrivingLicenseProvider =
            Provider.of<MovementDrivingLicenseProvider>(context, listen: true);

        movementDrivingLicenseProvider.inspectionReport = inspectionReport;

        return MenuPageContainer(
          "Fotos",
          "Nehmen Sie Bilder für das Übergabeprotokoll auf",
          Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: PageView(
                    controller: movementDrivingLicenseProvider.pageController,
                    onPageChanged: (index) {
                      movementDrivingLicenseProvider.pageChanged(index);
                    },
                    children: [
                      Card(
                        elevation: 8,
                        child: movementDrivingLicenseProvider.drivingLicense ==
                                null
                            ? Center(
                                child: Text(
                                  "Führerschein",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              )
                            : Stack(
                                fit: StackFit.expand,
                                children: [
                                  FullScreenWidget(
                                    disposeLevel: DisposeLevel.High,
                                    child: Hero(
                                      tag: "fullScreenImageDrivingLicense",
                                      child: Image.file(
                                        File(
                                          movementDrivingLicenseProvider
                                              .drivingLicense!.path,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      color: Theme.of(context)
                                          .primaryColorLight
                                          .withOpacity(0.5),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Führerschein",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                      Card(
                        elevation: 10,
                        child: movementDrivingLicenseProvider
                                    .drivingLicenseBack ==
                                null
                            ? Container(
                                child: Center(
                                  child: Text(
                                    "Führerschein Rückseite",
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                ),
                              )
                            : Stack(
                                fit: StackFit.expand,
                                children: [
                                  FullScreenWidget(
                                    backgroundColor: Colors.transparent,
                                    backgroundIsTransparent: true,
                                    disposeLevel: DisposeLevel.High,
                                    child: Hero(
                                      tag: "fullScreenImageDrivingLicenseBack",
                                      child: Image.file(
                                        File(
                                          movementDrivingLicenseProvider
                                              .drivingLicenseBack!.path,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      color: Theme.of(context)
                                          .primaryColorLight
                                          .withOpacity(0.5),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Führerschein Rückseite",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            highlightColor: Colors.white,
                            hoverColor: Colors.white,
                            disabledColor: Colors.red,
                            iconSize: 50,
                            icon: Icon(
                              Icons.camera_alt_outlined,
                            ),
                            onPressed: () {
                              movementDrivingLicenseProvider
                                  .takePicture(context);
                            },
                          ),
                          SizedBox(
                            width: 32,
                          ),
                          IconButton(
                            iconSize: 50,
                            icon: Icon(
                              Icons.delete_forever_outlined,
                            ),
                            onPressed: () {
                              movementDrivingLicenseProvider.deleteImage();
                            },
                          )
                        ],
                      ),
                      AnimatedSmoothIndicator(
                        activeIndex: movementDrivingLicenseProvider.currentPage,
                        count: 2,
                        effect: WormEffect(
                          activeDotColor:
                              Theme.of(context).colorScheme.secondary,
                          dotColor: Theme.of(context).primaryColorDark,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(64.0),
                          ),
                        ),
                      ),
                      child: Text(
                        "Fortfahren",
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context,
                            Constants.ROUTE_MOVEMENT_LICENSEPLATE_AND_MILES,
                            arguments: movementDrivingLicenseProvider
                                .inspectionReport);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title: Text(movementDrivingLicenseProvider
                .inspectionReport.vehicle!.licensePlate),
          ),
        );
      },
    );
  }
}
