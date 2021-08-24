import 'package:devtools/api.dart';
import 'package:devtools/storage.dart';
import 'package:easyrent/core/authenticator.dart';
import 'package:easyrent/core/constants.dart';
import 'package:easyrent/core/themes.dart';
import 'package:easyrent/services/camera/camera_page.dart';
import 'package:easyrent/services/images_history/images_history_page.dart';
import 'package:easyrent/services/images_new_vehicle/images_new_vehicle_page.dart';
import 'package:easyrent/services/images_vehicle_search_list/images_vehicle_search_list_page.dart';
import 'package:easyrent/services/menu/menu_page.dart';
import 'package:easyrent/services/vehicle_info/vehicle_info_page.dart';
import 'package:easyrent/services/vehicle_info_equipments/vehicle_info_equipments_page.dart';
import 'package:easyrent/services/vehicle_info_movements/vehicle_info_movements_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/application.dart';
import 'services/client/client_page.dart';
import 'services/login/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Storage().init();
  Authenticator.initAuthentication();

  runApp(
    ChangeNotifierProvider<Application>(
      create: (BuildContext context) => Application(),
      child: MaterialApp(
        theme: Themes.darkTheme,
        themeMode: ThemeMode.dark,
        home: BaseApplication(),
        initialRoute: Constants.ROUTE_HOME,
        routes: {
          Constants.ROUTE_LOGIN: (context) => LoginPage(),
          Constants.ROUTE_CLIENTS: (context) => ClientPage(),
          Constants.ROUTE_MENU: (context) => MenuPage(),
          Constants.ROUTE_CAMERA: (context) => CameraPage(),
          Constants.ROUTE_VEHICLE_INFO: (context) => VehicleInfoPage(),
          Constants.ROUTE_VEHICLE_INFO_MOVEMENTS: (context) =>
              VehicleInfoMovementsPage(),
          Constants.ROUTE_VEHICLE_INFO_EQUIPMENTS: (context) =>
              VehicleInfoEquipmentsPage(),
          Constants.ROUTE_CAMERA_VEHICLE_SEARCH_LIST: (context) =>
              ImagesVehicleSearchListPage(),
          Constants.ROUTE_IMAGES_NEW_VEHICLE: (context) =>
              ImagesNewVehiclePage(),
          Constants.ROUTE_IMAGES_HISTORY: (context) => ImagesHistoryPage(),
        },
      ),
    ),
  );
}

class BaseApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Authenticator.userLoggedIn() ? ClientPage() : LoginPage();
  }
}
