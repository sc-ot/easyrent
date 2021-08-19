import 'package:easyrent/models/vehicle.dart';
import 'package:easyrent/services/vehicle_info_movements/vehicle_info_movements_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VehicleInfoEquipmentsPage extends StatelessWidget {
  const VehicleInfoEquipmentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vehicle = ModalRoute.of(context)!.settings.arguments as Vehicle;

    return ChangeNotifierProvider(
      create: (BuildContext context) => VehicleInfoEquipmentsProvider(vehicle),
      builder: (context, child) {
        VehicleInfoEquipmentsProvider vehicleInfoEquipmentsProvider =
            Provider.of<VehicleInfoEquipmentsProvider>(context, listen: true);

        return Scaffold(
            appBar: AppBar(
              title: Text(
                "Ausstattungen",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            body: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {},
                  leading: Text(
                    (index + 1).toString(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  title: Text(
                      vehicleInfoEquipmentsProvider
                          .vehicle
                          .linkedVehicleEquipments[index]
                          .fleetVehicleEquipment
                          .equipmentName,
                      style: Theme.of(context).textTheme.subtitle2),
                  subtitle: Text(
                    vehicleInfoEquipmentsProvider
                        .vehicle
                        .linkedVehicleEquipments[index]
                        .fleetVehicleEquipment
                        .equipmentCode,
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: Theme.of(context).accentColor),
                  ),
                );
              },
              itemCount: vehicleInfoEquipmentsProvider
                  .vehicle.linkedVehicleEquipments.length,
            ));
      },
    );
  }
}
