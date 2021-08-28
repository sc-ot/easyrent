import 'package:easyrent/core/constants.dart';
import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/core/utils.dart';
import 'package:easyrent/models/movement_overview.dart';
import 'package:easyrent/models/planned_movement.dart';
import 'package:easyrent/services/images_new_vehicle/images_new_vehicle_provider.dart.dart';
import 'package:easyrent/services/movement_planned_movement_search_list/movement_planned_movement_search_list_provider.dart';
import 'package:easyrent/services/vehicle/vehicle_provider.dart';
import 'package:easyrent/widgets/loading_indicator.dart';
import 'package:easyrent/widgets/menu_page_container_widget.dart';
import 'package:easyrent/widgets/vehicle_search_list_entry.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class MovementPlannedMovementSearchListPage extends StatelessWidget {
  const MovementPlannedMovementSearchListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MovementPlannedMovementSearchListProvider>(
          create: (context) => MovementPlannedMovementSearchListProvider(),
        ),
        ChangeNotifierProvider<VehicleProvider>(
          create: (context) {
            VehicleProvider vehicleProvider = VehicleProvider(
              VEHICLELISTTYPE.STANDARD,
              () {},
            );

            return vehicleProvider;
          },
        ),
      ],
      builder: (context, child) {
        MovementPlannedMovementSearchListProvider
            movementPlannedMovementSearchListProvider =
            Provider.of<MovementPlannedMovementSearchListProvider>(context,
                listen: true);
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(
                    icon: Icon(
                      LineIcons.arrowDown,
                    ),
                    text: "Eingänge",
                  ),
                  Tab(
                    icon: Icon(
                      LineIcons.arrowUp,
                    ),
                    text: "Ausgänge",
                  ),
                ],
              ),
              title: Text(
                "Geplante Bewegung",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 32,
                  ),
                  Container(
                    child: TextField(
                      controller: movementPlannedMovementSearchListProvider
                          .plannedMovementSearchFieldTextEditingController,
                      onChanged: (text) {
                        movementPlannedMovementSearchListProvider
                            .getPlannedMovements(Constants.MOVEMENT_TYPE_ENTRY);
                        movementPlannedMovementSearchListProvider
                            .getPlannedMovements(Constants.MOVEMENT_TYPE_EXIT);
                      },
                      style: Theme.of(context).textTheme.headline5,
                      decoration: InputDecoration(
                        labelText: "Suchen",
                        labelStyle: Theme.of(context).textTheme.bodyText1,
                        counterStyle:
                            TextStyle(color: Theme.of(context).accentColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        PlannedMovementList(Constants.MOVEMENT_TYPE_ENTRY),
                        PlannedMovementList(Constants.MOVEMENT_TYPE_EXIT),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class PlannedMovementList extends StatelessWidget {
  final int movementType;
  const PlannedMovementList(this.movementType, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MovementPlannedMovementSearchListProvider
        movementPlannedMovementSearchListProvider =
        Provider.of<MovementPlannedMovementSearchListProvider>(context,
            listen: false);

    VehicleProvider vehicleProvider =
        Provider.of<VehicleProvider>(context, listen: false);

    List<PlannedMovement> plannedMovementsForPast = [];
    List<PlannedMovement> plannedMovementsForToday = [];
    List<PlannedMovement> plannedMovementsForFuture = [];
    bool plannedMovementsForPastExpanded = false;
    bool plannedMovementsForTodayExpanded = false;
    bool plannedMovementsForFutureExpanded = false;

    if (movementType == Constants.MOVEMENT_TYPE_ENTRY) {
      plannedMovementsForPast = movementPlannedMovementSearchListProvider
          .plannedMovements["entry_past"]!.plannedMovements;
      plannedMovementsForToday = movementPlannedMovementSearchListProvider
          .plannedMovements["entry_today"]!.plannedMovements;
      plannedMovementsForFuture = movementPlannedMovementSearchListProvider
          .plannedMovements["entry_future"]!.plannedMovements;

      plannedMovementsForPastExpanded =
          movementPlannedMovementSearchListProvider
              .plannedMovements["entry_past"]!.isExpanded;
      plannedMovementsForTodayExpanded =
          movementPlannedMovementSearchListProvider
              .plannedMovements["entry_today"]!.isExpanded;
      plannedMovementsForFutureExpanded =
          movementPlannedMovementSearchListProvider
              .plannedMovements["entry_future"]!.isExpanded;
    } else {
      plannedMovementsForPast = movementPlannedMovementSearchListProvider
          .plannedMovements["exit_past"]!.plannedMovements;
      plannedMovementsForToday = movementPlannedMovementSearchListProvider
          .plannedMovements["exit_today"]!.plannedMovements;
      plannedMovementsForFuture = movementPlannedMovementSearchListProvider
          .plannedMovements["exit_future"]!.plannedMovements;

      plannedMovementsForPastExpanded =
          movementPlannedMovementSearchListProvider
              .plannedMovements["exit_past"]!.isExpanded;
      plannedMovementsForTodayExpanded =
          movementPlannedMovementSearchListProvider
              .plannedMovements["exit_today"]!.isExpanded;
      plannedMovementsForFutureExpanded =
          movementPlannedMovementSearchListProvider
              .plannedMovements["exit_future"]!.isExpanded;
    }

    return movementPlannedMovementSearchListProvider.ui ==
            STATE.PLANNED_MOVEMENT_EXIT_AND_ENTRY_LOADED
        ? SingleChildScrollView(
            child: ExpansionPanelList(
              elevation: 1,
              expansionCallback: (int index, bool isExpanded) {
                movementPlannedMovementSearchListProvider.expandOrCloseHeader(
                    index, !isExpanded, movementType);
              },
              children: [
                ExpansionPanel(
                  canTapOnHeader: true,
                  isExpanded: plannedMovementsForTodayExpanded,
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text(
                        '${plannedMovementsForToday.length} heutige Bewegungen',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    );
                  },
                  body: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: plannedMovementsForToday.length,
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemBuilder: (context, index) {
                      vehicleProvider.onPressed = () => Navigator.pushNamed(
                            context,
                            Constants.ROUTE_MOVEMENT_OVERVIEW,
                            arguments: MovementOverview(
                              movementType,
                              null,
                              plannedMovementsForToday[index],
                            ),
                          );
                      return VehicleSearchListEntry(
                        plannedMovementsForToday[index].vehicle,
                        date: Utils.formatDateTimestringWithTime(
                            plannedMovementsForToday[index].movementDate),
                        elevation: 0,
                      );
                    },
                    shrinkWrap: true,
                  ),
                ),
                ExpansionPanel(
                  canTapOnHeader: true,
                  isExpanded: plannedMovementsForPastExpanded,
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text(
                        '${plannedMovementsForPast.length} vergangene Bewegungen',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    );
                  },
                  body: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: plannedMovementsForPast.length,
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemBuilder: (context, index) {
                      vehicleProvider.onPressed = () => Navigator.pushNamed(
                            context,
                            Constants.ROUTE_MOVEMENT_OVERVIEW,
                            arguments: MovementOverview(movementType, null,
                                plannedMovementsForPast[index]),
                          );
                      return VehicleSearchListEntry(
                        plannedMovementsForPast[index].vehicle,
                        date: Utils.formatDateTimestringWithTime(
                          plannedMovementsForPast[index].movementDate,
                        ),
                        elevation: 0,
                      );
                    },
                    shrinkWrap: true,
                  ),
                ),
                ExpansionPanel(
                  canTapOnHeader: true,
                  isExpanded: plannedMovementsForFutureExpanded,
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text(
                        '${plannedMovementsForFuture.length} zukünftige Bewegungen',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    );
                  },
                  body: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: plannedMovementsForFuture.length,
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemBuilder: (context, index) {
                      vehicleProvider.onPressed = () => Navigator.pushNamed(
                            context,
                            Constants.ROUTE_MOVEMENT_OVERVIEW,
                            arguments: MovementOverview(movementType, null,
                                plannedMovementsForFuture[index]),
                          );
                      return VehicleSearchListEntry(
                        plannedMovementsForFuture[index].vehicle,
                        date: Utils.formatDateTimestringWithTime(
                            plannedMovementsForFuture[index].movementDate),
                        elevation: 0,
                      );
                    },
                    shrinkWrap: true,
                  ),
                ),
              ],
            ),
          )
        : Center(
            child: ERLoadingIndicator(),
          );
  }
}
