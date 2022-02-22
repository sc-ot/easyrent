import 'package:easyrent/core/constants.dart';
import 'package:easyrent/models/camera.dart';
import 'package:easyrent/services/camera/camera_page.dart';
import 'package:easyrent/services/vehicle/vehicle_page.dart';
import 'package:easyrent/services/vehicle/vehicle_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovementProtocolReplacementVehiclePage extends StatelessWidget {
  const MovementProtocolReplacementVehiclePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: ChangeNotifierProvider<VehicleProvider>(
        create: (_) {
          VehicleProvider vehicleProvider = VehicleProvider(
            VEHICLELISTTYPE.STANDARD,
            () {},
          );
          vehicleProvider.onPressed = () => Navigator.pop(
                context,
                vehicleProvider.vehicle,
              );
          return vehicleProvider;
        },
        builder: (context, child) {
          return VehiclePage(
              "Fahrzeug", "Bitte wählen Sie das zu ersetzende Fahrzeug aus");
        },
      ),
    );
  }
}
