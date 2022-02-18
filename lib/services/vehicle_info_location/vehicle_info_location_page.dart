import 'package:easyrent/models/vehicle.dart';
import 'package:easyrent/services/vehicle_info_location/vehicle_info_location_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class VehicleInfoLocationPage extends StatefulWidget {
  VehicleInfoLocationPage({Key? key}) : super(key: key);

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 0.4746,
  );

  @override
  State<VehicleInfoLocationPage> createState() =>
      _VehicleInfoLocationPageState();
}

class _VehicleInfoLocationPageState extends State<VehicleInfoLocationPage> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final vehicle = ModalRoute.of(context)!.settings.arguments as Vehicle;

    return ChangeNotifierProvider(
      create: (BuildContext context) => VehicleInfoLocationProvider(vehicle),
      builder: (context, child) {
        VehicleInfoLocationProvider vehicleInfoLocationProvider =
            Provider.of<VehicleInfoLocationProvider>(context, listen: true);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Standort",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          body: GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: VehicleInfoLocationPage._kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              vehicleInfoLocationProvider.controller.complete(controller);
            },
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              print("PRESS");
            },
            label: Text('To the lake!'),
            icon: Icon(Icons.directions_boat),
          ),
        );
      },
    );
  }
}
