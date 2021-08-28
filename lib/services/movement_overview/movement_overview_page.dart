import 'package:easyrent/core/constants.dart';
import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/core/utils.dart';
import 'package:easyrent/models/movement_overview.dart';
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
        for (var entry
            in movementOverviewProvider.vehicleAppointments.entries) {
          if (entry.key == "Übergabedatum") {
            tiles.add(
              getListTile(
                context,
                entry.key,
                entry.value,
                changeTime: true,
              ),
            );
          } else {
            tiles.add(
              getListTile(
                context,
                entry.key,
                entry.value,
              ),
            );
          }
        }

        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(),
          body: movementOverviewProvider.ui == STATE.SUCCESS
              ? MenuPageContainer(
                  "Prüfungstermine",
                  "Überprüfen Sie die Daten",
                  Column(
                    children: [
                      Expanded(
                        flex: 6,
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return tiles[index];
                            },
                            separatorBuilder: (context, index) {
                              return Divider();
                            },
                            itemCount: tiles.length),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green),
                              child: Text(
                                "Fortfahren",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context,
                                    Constants
                                        .ROUTE_MOVEMENT_MILES_AND_LICENSE_PLATE);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  isMobile: Utils.getDevice(context) == Device.PHONE,
                )
              : Center(
                  child: ERLoadingIndicator(),
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
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: ListTile(
            contentPadding: EdgeInsets.all(16),
            trailing: IconButton(
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                movementOverviewProvider.changeDate(title, context,
                    changeTime: changeTime);
              },
            ),
            title: Text(
              title,
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    color: Theme.of(context).accentColor,
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
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
