import 'package:easyrent/core/constants.dart';
import 'package:easyrent/models/camera.dart';
import 'package:easyrent/services/camera/camera_page.dart';
import 'package:easyrent/services/images_new_vehicle/images_new_vehicle_provider.dart.dart';
import 'package:easyrent/widgets/menu_page_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImagesNewVehiclePage extends StatelessWidget {
  const ImagesNewVehiclePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: ChangeNotifierProvider<ImagesNewVehicleProvider>(
        create: (context) => ImagesNewVehicleProvider(),
        builder: (context, child) {
          ImagesNewVehicleProvider imagesNewVehicleProvider =
              Provider.of<ImagesNewVehicleProvider>(context, listen: false);
          return Scaffold(
            appBar: AppBar(),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.camera_alt),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Constants.ROUTE_CAMERA,
                  arguments: Camera(
                    CameraType.NEW_VEHICLE,
                    [],
                    null,
                    "ABC",
                  ),
                );
              },
            ),
            body: Padding(
              padding: const EdgeInsets.all(0),
              child: MenuPageContainer(
                "Fahrgestellnummer",
                "Bitte geben Sie die VIN vom Fahrzeug ein",
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextField(
                      controller: imagesNewVehicleProvider.vinTextEditingController,
                      style: Theme.of(context).textTheme.headline5,
                      decoration: InputDecoration(
                        labelText: "Fahrgestellnummer",
                        labelStyle: Theme.of(context).textTheme.bodyText1,
                        counterStyle:
                            TextStyle(color: Theme.of(context).accentColor),
                      ),
                      maxLength: 16,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
