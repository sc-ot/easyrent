import 'package:easyrent/core/constants.dart';
import 'package:easyrent/services/vehicle/vehicle_page.dart';
import 'package:easyrent/services/vehicle/vehicle_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuVehiclePage extends StatelessWidget {
  final String text;
  final String subTitle;
  const MenuVehiclePage(this.text, this.subTitle, {Key? key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        VehicleProvider vehicleProvider = VehicleProvider(
          VEHICLELISTTYPE.STANDARD,
          () {},
        );
        vehicleProvider.onPressed = () => Navigator.pushNamed(
            context, Constants.ROUTE_VEHICLE_INFO,
            arguments: vehicleProvider.vehicle.id);
        return vehicleProvider;
      },
      builder: (context, child) {
        return VehiclePage("Fahrzeug", "Fahrzeuginformationen anzeigen");
      },
    );
  }
}
