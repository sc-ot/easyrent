import 'package:easyrent/core/constants.dart';
import 'package:easyrent/models/movement_overview.dart';
import 'package:easyrent/services/vehicle/vehicle_page.dart';
import 'package:easyrent/services/vehicle/vehicle_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovementSearchListPage extends StatelessWidget {
  const MovementSearchListPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    int movementType = args as int;
    VEHICLELISTTYPE vehicleListType =
        movementType == Constants.MOVEMENT_TYPE_ENTRY
            ? VEHICLELISTTYPE.MOVEMENT_VEHICLES_ENTRY
            : VEHICLELISTTYPE.MOVEMENT_VEHICLES_EXIT;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: ChangeNotifierProvider<VehicleProvider>(
        create: (_) {
          VehicleProvider vehicleProvider = VehicleProvider(
            vehicleListType,
            () {},
          );
          vehicleProvider.onPressed = () => Navigator.pushNamed(
                context,
                Constants.ROUTE_MOVEMENT_OVERVIEW,
                arguments: MovementOverview(
                    movementType, vehicleProvider.vehicle, null),
              );
          return vehicleProvider;
        },
        builder: (context, child) {
          return VehiclePage(
            movementType == Constants.MOVEMENT_TYPE_ENTRY
                ? "Eingang"
                : "Ausgang",
            "Bitte wählen Sie ein Fahrzeug aus",
          );
        },
      ),
    );
  }
}
