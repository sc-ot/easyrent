import 'package:easyrent/core/constants.dart';
import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/core/utils.dart';
import 'package:easyrent/models/movement_overview.dart';
import 'package:easyrent/models/vehicle.dart';
import 'package:easyrent/services/vehicle/vehicle_provider.dart';
import 'package:easyrent/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../widgets/menu_page_container_widget.dart';
import 'movement_overview_provider.dart';

class MovementOverviewPage extends StatelessWidget {
  MovementOverviewPage({Key? key}) : super(key: key);

  final _form = GlobalKey<FormState>(); //for storing form state.

  @override
  Widget build(BuildContext context) {
    dynamic argument =
        ModalRoute.of(context)!.settings.arguments as MovementOverview;

    return ChangeNotifierProvider<MovementOverviewProvider>(
      create: (context) => MovementOverviewProvider(argument),
      builder: (context, child) {
        MovementOverviewProvider movementOverviewProvider =
            Provider.of<MovementOverviewProvider>(context, listen: true);

        return MenuPageContainer(
          "Prüfungstermine",
          "Überprüfen Sie die Daten",
          movementOverviewProvider.ui == STATE.SUCCESS
              ? Expanded(
                  child: Form(
                    key: _form,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 32,
                          ),
                          Container(
                            width: double.infinity,
                            child: Card(
                              color: Colors.red,
                              child: ListTile(
                                title: Text("Fahrzeug"),
                                subtitle: Text("Bitte Absprache mit Jola"),
                                trailing: Icon(
                                  Icons.warning,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Wrap(
                            spacing: 32,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Datum & Uhrzeit",
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  getTextField(context, "Übergabedatum",
                                      changeTime: true),
                                  SizedBox(
                                    height: 48,
                                  ),
                                ],
                              ),
                              movementOverviewProvider.inspectionReport.vehicle!
                                      .vehicleCategory.isConstructionVehicle
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Betriebsstunden",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        getTextFieldForOperatingHours(
                                            context, movementOverviewProvider),
                                        SizedBox(
                                          height: 48,
                                        ),
                                      ],
                                    )
                                  : Container(),
                            ],
                          ),
                          Text(
                            "Fahrzeugtermine",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Wrap(
                            runSpacing: 32,
                            spacing: 64,
                            children: [
                              getTextField(
                                context,
                                "Hauptuntersuchung",
                              ),
                              getTextField(
                                context,
                                "Sicherheitsprüfung",
                              ),
                              getTextField(
                                context,
                                "Tachoprüfung",
                              ),
                              getTextField(
                                context,
                                "UVV",
                              ),
                              TextFormField(
                                validator: (miles) {
                                  int? milesParsed = int.tryParse(miles ?? "");
                                  if (milesParsed != null) {
                                    movementOverviewProvider
                                        .updateMiles(milesParsed);
                                    return null;
                                  } else {
                                    return "Bitte Kilomerstand angeben!";
                                  }
                                },
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.speed),
                                    helperText: "Kilometerstand"),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Container(
                                  height: 48,
                                  width: double.infinity,
                                  child: ListTile(
                                    onTap: () async {
                                      if (movementOverviewProvider
                                          .replacementVehicleSelected()) {
                                        movementOverviewProvider
                                            .deleteToBeReplacedVehicle();
                                      } else {
                                        Vehicle? vehicle =
                                            await Navigator.pushNamed(
                                          context,
                                          Constants
                                              .ROUTE_MOVEMENT_PROTOCOL_REPLACEMENT_VEHICLE_LIST,
                                        ) as Vehicle?;
                                        if (vehicle != null) {
                                          movementOverviewProvider
                                              .setReplacementVehicle(vehicle);
                                        }
                                      }
                                    },
                                    title: Text(
                                      movementOverviewProvider
                                              .replacementVehicleSelected()
                                          ? "Zu ersetzende Fahrzeug: ${movementOverviewProvider.inspectionReport.replacementForVehicle!.licensePlate != "" ? movementOverviewProvider.inspectionReport.replacementForVehicle!.licensePlate : movementOverviewProvider.inspectionReport.replacementForVehicle!.vin != "" ? movementOverviewProvider.inspectionReport.replacementForVehicle!.vin : movementOverviewProvider.inspectionReport.replacementForVehicle!.vehicleNumber}"
                                          : "Zu ersetzendes Fahrzeug auswählen",
                                    ),
                                    subtitle: Text(
                                      movementOverviewProvider
                                              .replacementVehicleSelected()
                                          ? "Das Ersatzfahrzeug " +
                                              movementOverviewProvider
                                                  .getReplacementVehicleString() +
                                              " wird für das ersetzende Fahrzeug " +
                                              movementOverviewProvider
                                                  .getAccidentVehicleString() +
                                              " übergeben. Bitte klicken Sie auf das Lösch-Symbol, um diesen Vorgang rückgängig zu machen."
                                          : "Bitte wählen Sie ein zu ersetzendes Fahrzeug aus, falls Sie eine Übergabe mit einem Ersatzfahrzeug machen möchten. Klicken Sie hierzu auf das Fahrzeug-Symbol.",
                                    ),
                                    trailing: (Icon(
                                      movementOverviewProvider
                                              .replacementVehicleSelected()
                                          ? Icons.delete
                                          : Icons.directions_car,
                                    )),
                                  ),
                                ),
                              ),
                              Container(
                                height: 48,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    movementOverviewProvider.startMovement(
                                        _form, context);
                                  },
                                  child: Text(
                                    "Übergabe starten",
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Center(
                  child: ERLoadingIndicator(),
                ),
          appBar: AppBar(
            title: Text(
              movementOverviewProvider.vehicle.licensePlate,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        );
      },
    );
  }

  Widget getTextField(BuildContext context, String title,
      {bool changeTime = false}) {
    MovementOverviewProvider movementOverviewProvider =
        Provider.of<MovementOverviewProvider>(context, listen: false);

    return Container(
      width: MediaQuery.of(context).size.width * 0.44,
      child: TextField(
        readOnly: true,
        controller: TextEditingController(
          text: changeTime
              ? Utils.formatDateTimestringWithTime(
                  movementOverviewProvider
                      .vehicleAppointments[title]!["date_formatted"],
                  onError: "Nicht hinterlegt")
              : Utils.formatDateTimestring(
                  movementOverviewProvider
                      .vehicleAppointments[title]!["date_formatted"],
                  onError: "Nicht hinterlegt"),
        ),
        decoration: InputDecoration(
            suffixIcon: Icon(Icons.date_range), helperText: title),
        onTap: () {
          movementOverviewProvider.changeDate(title, context,
              changeTime: changeTime);
        },
      ),
    );
  }

  Widget getTextFieldForOperatingHours(
      BuildContext context, MovementOverviewProvider movementOverviewProvider) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.44,
      child: TextField(
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        controller:
            movementOverviewProvider.textEditingControllerOperatingHours,
        decoration: InputDecoration(
            suffixIcon: Icon(Icons.hourglass_bottom),
            helperText: "Betriebsstunden"),
      ),
    );
  }
}
