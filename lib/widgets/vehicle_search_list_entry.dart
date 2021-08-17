import 'package:easyrent/core/constants.dart';
import 'package:easyrent/models/camera_image.dart';
import 'package:flutter/material.dart';

class VehicleSearchListEntry extends StatelessWidget {
  final int vehicleId;
  final String vehicleNumber;
  final String vin;
  final String? manufacturerName;
  final String? vehicleCategoryName;

  const VehicleSearchListEntry(this.vehicleId, this.vehicleNumber, this.vin,
      this.manufacturerName, this.vehicleCategoryName,
      {Key? key})
      : super(key: key);

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
            arguments: 
              vehicleId,
            
          );
        },
        child: ListTile(
          trailing: Text(
            vehicleNumber,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Theme.of(context).accentColor),
            overflow: TextOverflow.ellipsis,
          ),
          title: Text(
            vin,
            style: Theme.of(context).textTheme.bodyText1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Text(
                  manufacturerName ?? "",
                  style: Theme.of(context).textTheme.bodyText2,
                  overflow: TextOverflow.fade,
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    vehicleCategoryName ?? "",
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
