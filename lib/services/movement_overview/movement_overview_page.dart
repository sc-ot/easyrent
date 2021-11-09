import 'package:easyrent/core/constants.dart';
import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/core/utils.dart';
import 'package:easyrent/models/movement_overview.dart';
import 'package:easyrent/widgets/custom_grid_view.dart';
import 'package:easyrent/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/menu_page_container_widget.dart';
import 'movement_overview_provider.dart';

class MovementOverviewPage extends StatelessWidget {
  const MovementOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic argument =
        ModalRoute.of(context)!.settings.arguments as MovementOverview;

    return ChangeNotifierProvider<MovementOverviewProvider>(
      create: (context) => MovementOverviewProvider(argument),
      builder: (context, child) {
        MovementOverviewProvider movementOverviewProvider =
            Provider.of<MovementOverviewProvider>(context, listen: true);

        List<Widget> tiles = [];
        List<Widget> textFields = [];
        for (var entry
            in movementOverviewProvider.vehicleAppointments.entries) {
          if (entry.key == "Übergabedatum") {
            tiles.add(
              getListTile(
                context,
                entry.key,
                entry.value["date_formatted"]!,
                changeTime: true,
              ),
            );
          } else {
            tiles.add(
              getListTile(
                context,
                entry.key,
                entry.value["date_formatted"]!,
              ),
            );
          }
        }

        textFields.add(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: movementOverviewProvider.textEditingControllerMiles,
              onChanged: (miles) {
                //  movementOverviewProvider.milesChanged(miles);
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Kilometerstand",
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        );

        textFields.add(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller:
                  movementOverviewProvider.textEditingControllerLicensePlate,
              decoration: InputDecoration(
                labelText: "Kennzeichen",
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        );

        return MenuPageContainer(
          "Prüfungstermine",
          "Überprüfen Sie die Daten",
          movementOverviewProvider.ui == STATE.SUCCESS
              ? Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomGridView(
                          fillEmptySpace: false,
                          mainAxisCount:
                              Utils.getDevice(context) == Device.PHONE ? 1 : 2,
                          builder: (context, index) {
                            return tiles[index];
                          },
                          list: tiles,
                        ),
                        CustomGridView(
                          fillEmptySpace: false,
                          mainAxisCount:
                              Utils.getDevice(context) == Device.PHONE ? 1 : 2,
                          builder: (context, index) {
                            return textFields[index];
                          },
                          list: textFields,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(64.0),
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  "Fortfahren",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context,
                                    Constants.ROUTE_MOVEMENT_DRIVING_LICENSE,
                                    arguments: movementOverviewProvider
                                        .inspectionReport);
                              },
                            ),
                          ),
                        ),
                      ],
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

  Widget getListTile(BuildContext context, String title, String value,
      {bool changeTime = false}) {
    MovementOverviewProvider movementOverviewProvider =
        Provider.of<MovementOverviewProvider>(context, listen: false);

    return Card(
      elevation: 8,
      child: InkWell(
        onTap: () {
          movementOverviewProvider.changeDate(title, context);
        },
        child: ListTile(
          contentPadding: EdgeInsets.all(32),
          trailing: IconButton(
            icon: Icon(
              Icons.edit,
              color: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () {
              movementOverviewProvider.changeDate(title, context,
                  changeTime: changeTime);
            },
          ),
          title: Text(
            title,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  overflow: TextOverflow.ellipsis,
                ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: Text(
              changeTime
                  ? Utils.formatDateTimestringWithTime(value,
                      onError: "Nicht hinterlegt")
                  : Utils.formatDateTimestring(value,
                      onError: "Nicht hinterlegt"),
              style: Theme.of(context).textTheme.bodyText1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
