import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/core/utils.dart';
import 'package:easyrent/models/vehicle.dart';
import 'package:easyrent/services/vehicle_info_equipments/vehicle_info_equipments_provider.dart';
import 'package:easyrent/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VehicleInfoMovementsPage extends StatelessWidget {
  const VehicleInfoMovementsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vehicle = ModalRoute.of(context)!.settings.arguments as Vehicle;

    return ChangeNotifierProvider(
      create: (BuildContext context) => VehicleInfoMovementsProvider(vehicle),
      builder: (context, child) {
        VehicleInfoMovementsProvider vehicleInfoMovementsProvider =
            Provider.of<VehicleInfoMovementsProvider>(context, listen: true);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Bewegungen",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          body: vehicleInfoMovementsProvider.ui == STATE.SUCCESS
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    return VehicleInfoMovementCard(
                      [
                        VehicleInfoMovementCardRow(
                          "Kennzeichen",
                          vehicleInfoMovementsProvider
                              .movements[index].vehicle.licensePlate,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        VehicleInfoMovementCardRow(
                          "Kontakt",
                          vehicleInfoMovementsProvider
                              .movements[index].contact.orgName,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        VehicleInfoMovementCardRow(
                          "Kilometer",
                          vehicleInfoMovementsProvider
                                  .movements[index].currentMileage
                                  .toString() +
                              " km",
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                      Utils.formatDateTimestringWithTime(vehicleInfoMovementsProvider
                          .movements[index].movementDate),
                    );
                  },
                  itemCount: vehicleInfoMovementsProvider.movements.length,
                )
              : Center(
                  child: ERLoadingIndicator(),
                ),
        );
      },
    );
  }
}

class VehicleInfoMovementCard extends StatelessWidget {
  List<Widget> vehicleInfoMovementCardRow = [];
  String date;
  VehicleInfoMovementCard(this.vehicleInfoMovementCardRow, this.date,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              date,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          SizedBox(height: 8,),
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 7,
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: vehicleInfoMovementCardRow,
                ),
              ),
            ),
          ),
           SizedBox(height: 8,),
        ],
      ),
    );
  }
}

class VehicleInfoMovementCardRow extends StatelessWidget {
  final String title;
  final String value;
  const VehicleInfoMovementCardRow(this.title, this.value, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(title, style: Theme.of(context).textTheme.bodyText1!),
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          flex: 3,
          child: Text(
            value.isEmpty ? "-" : value,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ],
    );
  }
}
