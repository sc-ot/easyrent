import 'dart:io';

import 'package:easyrent/core/constants.dart';
import 'package:easyrent/models/inspection_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../widgets/menu_page_container_widget.dart';
import 'movement_protocol_tire_profile_provider.dart';

class MovementProtocolTireProfilePage extends StatelessWidget {
  const MovementProtocolTireProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    InspectionReport inspectionReport = args as InspectionReport;
    return ChangeNotifierProvider<MovementProtocolTireProfileProvider>(
      create: (context) =>
          MovementProtocolTireProfileProvider(inspectionReport),
      builder: (context, child) {
        MovementProtocolTireProfileProvider
            movementProtocolTireProfileProvider =
            Provider.of<MovementProtocolTireProfileProvider>(context,
                listen: true);

        // PADDING FOR BOTTOM SO THE NEXT BUTTON DOESNT OVERLAP WITH AXIS
        double bottomPadding = 120.0;
        double bottomAdditionalPadding = 16;
        // PADDING FOR TOP (QUESTION COUNT)
        double topPadding = MediaQuery.of(context).size.height * 0.1;
        // PADDING LEFT AND RIGHT
        double horizontalPadding = 16;
        // TIRE SVG SIZE
        double tireSize = 100.0;
        // AXIS CONTAINER HEIGHT
        double axisHeight = 4.0;

        List<Widget> axes = movementProtocolTireProfileProvider
                .inspectionReport.vehicle?.axisProfile?.axis
                .map(
              (axis) {
                int index = movementProtocolTireProfileProvider
                    .inspectionReport.vehicle!.axisProfile!.axis
                    .indexOf(axis);

                // TIRES LEFT SIDE
                List<Widget> tiresLeft = axis.wheelsLeft.map(
                  (element) {
                    return tireWidget(tireSize);
                  },
                ).toList();

                // TIRES RIGHT SIDE
                List<Widget> tiresRight = axis.wheelsRight.map(
                  (element) {
                    return tireWidget(tireSize);
                  },
                ).toList();

                // AXIS
                return Column(
                  children: [
                    Container(
                      child: Row(
                        children: tiresLeft +
                            [
                              ElevatedButton(
                                onPressed: () {
                                  movementProtocolTireProfileProvider
                                      .deleteAxis(index);
                                },
                                child: Icon(Icons.remove, color: Colors.white),
                                style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(8),
                                  primary:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              )
                            ] +
                            tiresRight,
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton.icon(
                            icon: Icon(
                              Icons.add,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            label: Text(
                              "Reifen hinzufügen",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            onPressed: () {
                              movementProtocolTireProfileProvider
                                  .addTire(index);
                            },
                          ),
                          TextButton.icon(
                            icon: Icon(
                              Icons.remove,
                              color: Colors.red,
                            ),
                            label: Text(
                              "Reifen entfernen",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            onPressed: () {
                              movementProtocolTireProfileProvider
                                  .removeTire(index);
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
            ).toList() ??
            <Widget>[];

        // TIRE PROFILE SCREEN
        return Padding(
          padding: EdgeInsets.fromLTRB(
              horizontalPadding,
              topPadding,
              horizontalPadding,
              bottomAdditionalPadding + bottomAdditionalPadding),
          child: Stack(
            children: [
              /* Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: topPadding + (tireSize / 2),
                    bottom: bottomPadding +
                        bottomAdditionalPadding +
                        (tireSize / 2),
                  ),
                  child: Container(
                    width: axisHeight,
                    color: Colors.white,
                  ),
                ),
              ),*/
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: axes,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget tireWidget(double tireSize) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          child: SvgPicture.asset(
            "assets/tire.svg",
            height: tireSize,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
