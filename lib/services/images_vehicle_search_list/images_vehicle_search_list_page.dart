import 'package:easyrent/core/constants.dart';
import 'package:easyrent/models/camera.dart';
import 'package:easyrent/services/camera/camera_page.dart';
import 'package:easyrent/services/vehicle/vehicle_page.dart';
import 'package:easyrent/services/vehicle/vehicle_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImagesVehicleSearchListPage extends StatelessWidget {
  const ImagesVehicleSearchListPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    CameraType cameraType = args as CameraType;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: ChangeNotifierProvider<VehicleProvider>(
        create: (_) {
          VehicleProvider vehicleProvider = VehicleProvider(
            VEHICLELISTTYPE.STANDARD,
            () {},
          );
          vehicleProvider.onPressed = () => Navigator.pushNamed(
                context,
                Constants.ROUTE_CAMERA,
                arguments: Camera(
                  cameraType,
                  [
                    "Frontal",
                    "Frontal-Links",
                    "Links",
                    "Heck-Links",
                    "Heck",
                    "Heck-Rechts",
                    "Rechts",
                    "Frontal-Rechts"
                  ],
                  vehicleProvider.vehicle,
                  null,
                ),
              );
          return vehicleProvider;
        },
        builder: (context, child) {
          return VehiclePage("Fahrzeug", "Bitte wählen Sie ein Fahrzeug aus");
        },
      ),
    );
  }
}
