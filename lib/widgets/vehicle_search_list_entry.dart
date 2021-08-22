import 'package:easyrent/core/constants.dart';
import 'package:easyrent/models/vehicle.dart';
import 'package:easyrent/services/vehicle/vehicle_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VehicleSearchListEntry extends StatelessWidget {
  final Vehicle vehicle;
  const VehicleSearchListEntry(this.vehicle, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VehicleProvider vehicleProvider = Provider.of(context, listen: false);

    return Card(
      elevation: 3,
      color: Theme.of(context).primaryColorLight,
      child: InkWell(
        onTap: () async {
          vehicleProvider.vehicle = vehicle;
          await vehicleProvider.onPressed.call();
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
                      vehicle.vin,
                      style: Theme.of(context).textTheme.bodyText1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          vehicle.manufacturer.manufacturerName,
                          style: Theme.of(context).textTheme.bodyText2,
                          overflow: TextOverflow.fade,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Text(
                            vehicle.vehicleCategory.vehicleCategoryName,
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
                      vehicle.licensePlate,
                      style: Theme.of(context).textTheme.bodyText2,
                      overflow: TextOverflow.fade,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  vehicle.vehicleNumber,
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

        /*ListTile(
          trailing: Text(
            vehicle.vehicleNumber,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Theme.of(context).accentColor),
            overflow: TextOverflow.ellipsis,
          ),
          title: Text(
            vehicle.vin,
            style: Theme.of(context).textTheme.bodyText1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      vehicle.manufacturer.manufacturerName,
                      style: Theme.of(context).textTheme.bodyText2,
                      overflow: TextOverflow.fade,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        vehicle.vehicleCategory.vehicleCategoryName,
                        style: Theme.of(context).textTheme.bodyText1,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                Text(
                      vehicle.licensePlate,
                      style: Theme.of(context).textTheme.bodyText2,
                      overflow: TextOverflow.fade,
                    ),
              ],
            ),
          ),*/
      ),
    );
  }
}
