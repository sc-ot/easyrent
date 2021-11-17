import 'package:easyrent/models/vehicle.dart';
import 'package:easyrent/services/vehicle/vehicle_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VehicleSearchListEntry extends StatelessWidget {
  final Vehicle vehicle;
  final String? date;
  final double elevation;
  final Function? onTap;
  const VehicleSearchListEntry(this.vehicle,
      {Key? key, this.date, this.elevation = 3, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    VehicleProvider vehicleProvider = Provider.of(context, listen: false);

    List<Widget> dateWidget = [];
    if (date != null) {
      dateWidget = [
        SizedBox(
          height: 8,
        ),
        Text(
          date!,
          style: Theme.of(context).textTheme.bodyText2,
          overflow: TextOverflow.fade,
        ),
      ];
    }
    return Card(
      elevation: elevation,
      color: Theme.of(context).primaryColorLight,
      child: InkWell(
        onTap: () async {
          vehicleProvider.vehicle = vehicle;
          if (onTap == null) {
            await vehicleProvider.onPressed.call();
          } else {
            await onTap!.call();
          }
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
                      style: Theme.of(context).textTheme.bodyText2,
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
                            style: Theme.of(context).textTheme.bodyText2,
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
                    ...dateWidget,
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  vehicle.vehicleNumber,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: Theme.of(context).colorScheme.secondary),
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
