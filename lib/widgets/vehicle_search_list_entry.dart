import 'package:easyrent/core/constants.dart';
import 'package:easyrent/models/vehicle.dart';
import 'package:flutter/material.dart';

class VehicleSearchListEntry extends StatelessWidget {
  final Vehicle vehicle;
  const VehicleSearchListEntry(this.vehicle, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Theme.of(context).primaryColorLight,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            Constants.ROUTE_VEHICLE_INFO,
            arguments: vehicle,
          );
        },
        child: ListTile(
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
            child: Row(
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
                    vehicle.vehicleCategory.vehicleCategoryName ,
                    style: Theme.of(context).textTheme.bodyText1,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
