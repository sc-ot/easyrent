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
                        VehicleInfoMovementCardRow(
                          "Datum",
                          Utils.formatDateTimestring(
                              vehicleInfoMovementsProvider
                                  .movements[index].movementDate),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
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
  VehicleInfoMovementCard(this.vehicleInfoMovementCardRow, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 7,
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: vehicleInfoMovementCardRow,
            ),
          ),
        ),
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
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
            flex: 3,
            child: Text(
              value.isEmpty ? "-" : value,
              style: Theme.of(context).textTheme.bodyText1,
            )),
      ],
    );
  }
}
