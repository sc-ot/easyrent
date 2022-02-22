import 'dart:io';

import 'package:easyrent/core/constants.dart';
import 'package:easyrent/models/inspection_report.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/menu_page_container_widget.dart';
import 'movement_protocol_display_provider.dart';

class MovementProtocolDisplayPage extends StatelessWidget {
  const MovementProtocolDisplayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    InspectionReport inspectionReport = args as InspectionReport;
    return ChangeNotifierProvider<MovementProtocolDisplayProvider>(
      create: (context) => MovementProtocolDisplayProvider(),
      builder: (context, child) {
        MovementProtocolDisplayProvider movementProtocolDisplayProvider =
            Provider.of<MovementProtocolDisplayProvider>(context, listen: true);

        movementProtocolDisplayProvider.inspectionReport = inspectionReport;

        return MenuPageContainer(
          "Display",
          "Nehmen Sie Bilder für das Übergabeprotokoll auf",
          Expanded(
            child: Column(
              children: [
                Flexible(
                  child: Card(
                    elevation: 7,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        movementProtocolDisplayProvider.display != null
                            ? Container(
                                width: 300,
                                child: Image.file(
                                  File(movementProtocolDisplayProvider
                                      .display!.path),
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
                                "Display",
                                style: Theme.of(context).textTheme.headline4,
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
                                    movementProtocolDisplayProvider
                                        .takePicture(context);
                                  },
                                  child: Text(
                                    "Foto aufnehmen",
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        movementProtocolDisplayProvider.display != null
                            ? Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      onPressed: () {
                                        movementProtocolDisplayProvider
                                            .deleteImage();
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
                Container(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, Constants.ROUTE_MOVEMENT_PROTOCOL,
                          arguments:
                              movementProtocolDisplayProvider.inspectionReport);
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
            title: Text(movementProtocolDisplayProvider
                .inspectionReport.vehicle!.licensePlate),
          ),
        );
      },
    );
  }
}
