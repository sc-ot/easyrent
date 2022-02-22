import 'dart:io';

import 'package:easyrent/core/constants.dart';
import 'package:easyrent/models/inspection_report.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/menu_page_container_widget.dart';
import 'movement_protocol_driving_license_provider.dart';

class MovementProtocolDrivingLicensePage extends StatelessWidget {
  const MovementProtocolDrivingLicensePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    InspectionReport inspectionReport = args as InspectionReport;
    return ChangeNotifierProvider<MovementProtocolDrivingLicenseProvider>(
      create: (context) => MovementProtocolDrivingLicenseProvider(),
      builder: (context, child) {
        MovementProtocolDrivingLicenseProvider
            movementProtocolDrivingLicenseProvider =
            Provider.of<MovementProtocolDrivingLicenseProvider>(context,
                listen: true);

        movementProtocolDrivingLicenseProvider.inspectionReport =
            inspectionReport;

        return MenuPageContainer(
          "Führerschein",
          "Nehmen Sie Bilder für das Übergabeprotokoll auf",
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Card(
                          elevation: 7,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              movementProtocolDrivingLicenseProvider
                                          .drivingLicense !=
                                      null
                                  ? Container(
                                      width: 300,
                                      child: Image.file(
                                        File(
                                            movementProtocolDrivingLicenseProvider
                                                .drivingLicense!.path),
                                        fit: BoxFit.fitWidth,
                                      ),
                                    )
                                  : Container(),
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Spacer(),
                                    Text(
                                      "Führerschein",
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                    Spacer(),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      color: Colors.grey.withOpacity(0.5),
                                      height: 64,
                                      child: TextButton(
                                        onPressed: () {
                                          movementProtocolDrivingLicenseProvider
                                              .takePicture(false, context);
                                        },
                                        child: Text(
                                          "Foto aufnehmen",
                                          style: Theme.of(context)
                                              .textTheme
                                              .button,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              movementProtocolDrivingLicenseProvider
                                          .drivingLicense !=
                                      null
                                  ? Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                            onPressed: () {
                                              movementProtocolDrivingLicenseProvider
                                                  .deleteImage(false);
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Flexible(
                        child: Card(
                          elevation: 7,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              movementProtocolDrivingLicenseProvider
                                          .drivingLicenseBack !=
                                      null
                                  ? Container(
                                      width: 300,
                                      child: Image.file(
                                        File(
                                            movementProtocolDrivingLicenseProvider
                                                .drivingLicenseBack!.path),
                                        fit: BoxFit.fitWidth,
                                      ),
                                    )
                                  : Container(),
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Spacer(),
                                    Text(
                                      "Führerschein Rückseite",
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                    Spacer(),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      color: Colors.grey.withOpacity(0.5),
                                      height: 64,
                                      child: TextButton(
                                        onPressed: () {
                                          movementProtocolDrivingLicenseProvider
                                              .takePicture(true, context);
                                        },
                                        child: Text(
                                          "Foto aufnehmen",
                                          style: Theme.of(context)
                                              .textTheme
                                              .button,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              movementProtocolDrivingLicenseProvider
                                          .drivingLicenseBack !=
                                      null
                                  ? Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                            onPressed: () {
                                              movementProtocolDrivingLicenseProvider
                                                  .deleteImage(true);
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Container(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, Constants.ROUTE_MOVEMENT_PROTOCOL_DISPLAY,
                          arguments: movementProtocolDrivingLicenseProvider
                              .inspectionReport);
                    },
                    child: Text(
                      "Fortfahren",
                      style: Theme.of(context).textTheme.button,
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
            title: Text(movementProtocolDrivingLicenseProvider
                .inspectionReport.vehicle!.licensePlate),
          ),
        );
      },
    );
  }
}
