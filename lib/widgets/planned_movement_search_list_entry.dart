import 'package:easyrent/core/utils.dart';
import 'package:easyrent/models/planned_movement.dart';
import 'package:easyrent/services/movement_planned_movement_search_list/movement_planned_movement_search_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlannedMovementSearchListEntry extends StatelessWidget {
  final PlannedMovement plannedMovement;
  final double elevation;
  const PlannedMovementSearchListEntry(this.plannedMovement,
      {Key? key, this.elevation = 3});

  @override
  Widget build(BuildContext context) {
    MovementPlannedMovementSearchListProvider
        movementPlannedMovementSearchListProvider =
        Provider.of(context, listen: false);


    return Card(
      elevation: elevation,
      color: Theme.of(context).primaryColorLight,
      child: InkWell(
        onTap: () async {
          movementPlannedMovementSearchListProvider.plannedMovement = plannedMovement;
          
          await movementPlannedMovementSearchListProvider.onPressed.call();
          FocusScope.of(context).requestFocus(
            FocusNode(),
          );
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
          child: Row(
            children: [
              Expanded(
                flex: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plannedMovement.vehicle.vin,
                      style: Theme.of(context).textTheme.bodyText1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          plannedMovement.vehicle.manufacturer.manufacturerName,
                          style: Theme.of(context).textTheme.bodyText2,
                          overflow: TextOverflow.fade,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Text(
                            plannedMovement
                                .vehicle.vehicleCategory.vehicleCategoryName,
                            style: Theme.of(context).textTheme.bodyText1,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      plannedMovement.vehicle.licensePlate,
                      style: Theme.of(context).textTheme.bodyText2,
                      overflow: TextOverflow.fade,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      Utils.formatDateTimestringWithTime(plannedMovement.movementDate),
                      style: Theme.of(context).textTheme.bodyText2,
                      overflow: TextOverflow.fade,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  plannedMovement.vehicle.vehicleNumber,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Theme.of(context).accentColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
