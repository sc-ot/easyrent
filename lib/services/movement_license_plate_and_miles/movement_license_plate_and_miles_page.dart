import 'dart:io';

import 'package:easyrent/core/constants.dart';
import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/models/inspection_report.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../widgets/menu_page_container_widget.dart';
import 'movement_license_plate_and_miles_provider.dart';

class MovementLicensPlateAndMilesPage extends StatelessWidget {
  const MovementLicensPlateAndMilesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    InspectionReport inspectionReport = args as InspectionReport;
    return ChangeNotifierProvider<MovementLicensPlateAndMilesProvider>(
      create: (context) =>
          MovementLicensPlateAndMilesProvider(inspectionReport),
      builder: (context, child) {
        MovementLicensPlateAndMilesProvider
            movementLicensPlateAndMilesProvider =
            Provider.of<MovementLicensPlateAndMilesProvider>(context,
                listen: true);

        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(movementLicensPlateAndMilesProvider
                .inspectionReport.vehicle!.licensePlate),
          ),
          body: MenuPageContainer(
            "Kennzeichen und Kilometerstand",
            "Bitte überprüfen Sie die Daten",
            Column(
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                    children: [
                      TextField(
                        controller: movementLicensPlateAndMilesProvider
                            .textEditingControllerLicensePlate,
                        decoration: InputDecoration(
                          labelText: "Kennzeichen",
                          labelStyle: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Theme.of(context).accentColor),
                        ),
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      TextField(
                        controller: movementLicensPlateAndMilesProvider
                            .textEditingControllerMiles,
                        onChanged: (miles) {
                          movementLicensPlateAndMilesProvider
                              .milesChanged(miles);
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Kilometerstand",
                          labelStyle: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Theme.of(context).accentColor),
                        ),
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            movementLicensPlateAndMilesProvider.ui ==
                                    STATE.SUCCESS
                                ? MaterialStateProperty.all<Color>(
                                    Theme.of(context).accentColor)
                                : MaterialStateProperty.all<Color>(Colors.grey),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(64.0),
                          ),
                        ),
                      ),
                      child: Text(
                        "Übergabeprotokoll starten",
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.white),
                      ),
                      onPressed: movementLicensPlateAndMilesProvider.ui ==
                              STATE.SUCCESS
                          ? () {
                              Navigator.pushNamed(
                                  context, Constants.ROUTE_MOVEMENT_PROTOCOL,
                                  arguments: movementLicensPlateAndMilesProvider
                                      .inspectionReport);
                            }
                          : () {},
                    ),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
