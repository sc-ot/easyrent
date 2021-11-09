import 'package:dartz/dartz.dart';
import 'package:devtools/sc_shared_prefs_storage.dart';
import 'package:easyrent/core/authenticator.dart';
import 'package:easyrent/core/constants.dart';
import 'package:easyrent/core/themes.dart';
import 'package:easyrent/services/camera/camera_page.dart';
import 'package:easyrent/services/image_history_galery/images_history_galery_page.dart';
import 'package:easyrent/services/image_log/images_log_page.dart';
import 'package:easyrent/services/images_history/images_history_page.dart';
import 'package:easyrent/services/images_new_vehicle/images_new_vehicle_page.dart';
import 'package:easyrent/services/images_vehicle_search_list/images_vehicle_search_list_page.dart';
import 'package:easyrent/services/menu/menu_page.dart';
import 'package:easyrent/services/movement_driving_license/movement_driving_license_page.dart';
import 'package:easyrent/services/movement_license_plate_and_miles/movement_license_plate_and_miles_page.dart';
import 'package:easyrent/services/movement_overview/movement_overview_page.dart';
import 'package:easyrent/services/movement_planned_movement_search_list/movement_planned_movement_search_list_page.dart';
import 'package:easyrent/services/movement_protocol/movement_protocol_page.dart';
import 'package:easyrent/services/movement_search_list/movement_search_list_page.dart';
import 'package:easyrent/services/vehicle_info/vehicle_info_page.dart';
import 'package:easyrent/services/vehicle_info_equipments/vehicle_info_equipments_page.dart';
import 'package:easyrent/services/vehicle_info_movements/vehicle_info_movements_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'core/application.dart';
import 'services/client/client_page.dart';
import 'services/login/login_page.dart';

//import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SCSharedPrefStorage().init();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Authenticator.initAuthentication();

  runApp(
    ChangeNotifierProvider<Application>(
      create: (BuildContext context) => Application(),
      builder: (context, child) {
        Application application =
            Provider.of<Application>(context, listen: true);
        return OverlaySupport.global(
          child: ResponsiveSizer(
            builder: (a, b, c) {
              return MaterialApp(
                localizationsDelegates: [
                  //  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: [
                  Locale('de', ''), // English, no country code
                ],
                theme: Themes.getLightTheme(),
                darkTheme: Themes.getDarkTheme(),
                themeMode: application.themeMode,
                home: BaseApplication(),
                initialRoute: Constants.ROUTE_HOME,
                navigatorKey: navigatorKey,
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
                  Constants.ROUTE_IMAGES_HISTORY: (context) =>
                      ImagesHistoryPage(),
                  Constants.ROUTE_IMAGES_HISTORY_GALERY: (context) =>
                      ImagesHistoryGaleryPage(),
                  Constants.ROUTE_MOVEMENT_PLANNED_MOVEMENT_SEARCH_LIST:
                      (context) => MovementPlannedMovementSearchListPage(),
                  Constants.ROUTE_MOVEMENT_SEARCH_LIST: (context) =>
                      MovementSearchListPage(),
                  Constants.ROUTE_MOVEMENT_OVERVIEW: (context) =>
                      MovementOverviewPage(),
                  Constants.ROUTE_MOVEMENT_DRIVING_LICENSE: (context) =>
                      MovementDrivingLicensePage(),
                  Constants.ROUTE_MOVEMENT_LICENSEPLATE_AND_MILES: (context) =>
                      MovementLicensPlateAndMilesPage(),
                  Constants.ROUTE_MOVEMENT_PROTOCOL: (context) =>
                      MovementProtocolPage(),
                  Constants.ROUTE_IMAGES_LOG_PAGE: (context) => ImagesLogPage(),
                },
              );
            },
          ),
        );
      },
    ),
  );
}

class BaseApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("assets/menu_entrance.jpeg"), context);
    precacheImage(AssetImage("assets/menu_exit.jpeg"), context);
    precacheImage(AssetImage("assets/menu_planned_movement.png"), context);
    return Authenticator.userLoggedIn() ? ClientPage() : LoginPage();
  }
}
