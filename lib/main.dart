import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:easyrent/core/authenticator.dart';
import 'package:easyrent/core/constants.dart';
import 'package:easyrent/core/themes.dart';
import 'package:easyrent/models/fleet_vehicle_image.dart';
import 'package:easyrent/network/repository.dart';
import 'package:easyrent/services/camera/camera_page.dart';
import 'package:easyrent/services/camera/image_uploader.dart';
import 'package:easyrent/services/image_cache_log/image_cache_log_page.dart';
import 'package:easyrent/services/image_history_galery/image_history_galery_page.dart';
import 'package:easyrent/services/image_log/image_log_page.dart';
import 'package:easyrent/services/menu/menu_page.dart';
import 'package:easyrent/services/movement_driving_license/movement_driving_license_page.dart';
import 'package:easyrent/services/movement_license_plate_and_miles/movement_license_plate_and_miles_page.dart';
import 'package:easyrent/services/movement_overview/movement_overview_page.dart';
import 'package:easyrent/services/movement_planned_movement_search_list/movement_planned_movement_search_list_page.dart';
import 'package:easyrent/services/movement_protocol/movement_protocol_page.dart';
import 'package:easyrent/services/movement_protocol_pdf_preview/movement_protocol_pdf_preview_page.dart';
import 'package:easyrent/services/movement_protocol_question_overview_list/movement_protocol_question_overview_page.dart';
import 'package:easyrent/services/movement_search_list/movement_search_list_page.dart';
import 'package:easyrent/services/vehicle_info/vehicle_info_page.dart';
import 'package:easyrent/services/vehicle_info_equipments/vehicle_info_equipments_page.dart';
import 'package:easyrent/services/vehicle_info_location/vehicle_info_location_page.dart';
import 'package:easyrent/services/vehicle_info_movements/vehicle_info_movements_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sc_appframework/network/sc_cache_request_handler.dart';
import 'package:sc_appframework/network/sc_network_api.dart';
import 'package:sc_appframework/storage/sc_shared_prefs_storage.dart';

import 'core/application.dart';
import 'services/client/client_page.dart';
import 'services/image_history/image_history_page.dart';
import 'services/image_new_vehicle/image_new_vehicle_page.dart';
import 'services/image_vehicle_search_list/image_vehicle_search_list_page.dart';
import 'services/login/login_page.dart';

// bei start alle Bilder hochladen
// bei start alle Bilder vor upload überprüfen ob schon vorhanden, wenn ja

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> removeImageRequests() async {
  await SCNetworkApi().deSerializeRequests(startCachedRequests: false);
  List<SCCachedRequest> cachedRequests = SCNetworkApi().cachedRequests;
  for (int i = 0; i < cachedRequests.length; i++) {
    // TODO CHANGE IF CONDITION
    if (cachedRequests[i].method == Method.MULTIPART) {
      var response = await EasyRentRepository().checkIfImageExists(
          cachedRequests[i].filePayload!.filePath.split("/").last);
      await response.fold(
          (l) => null,
          await (result) async {
            result = result as FleetVehicleImage;
            if (result.id != 0) {
              try {
                File file = File(
                    SCNetworkApi().cachedRequests[i].filePayload!.filePath);
                await file.delete();
              } catch (e) {
                print(e);
              }

              SCNetworkApi().cachedRequests.removeAt(i);
            }
          });
    }
  }

  await SCNetworkApi().serializeRequests();
  SCNetworkApi().deSerializeRequests(startCachedRequests: true);
}

void main() async {
  Isolate.current.addErrorListener(RawReceivePort((pair) async {
    final List<dynamic> errorAndStacktrace = pair;
    await FirebaseCrashlytics.instance.recordError(
      errorAndStacktrace.first,
      errorAndStacktrace.last,
    );
  }).sendPort);

  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SCSharedPrefStorage().init();

    await Firebase.initializeApp();

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Authenticator.initAuthentication();
    await removeImageRequests();
    ImageUploader.uploadAllCachedImages();
    runApp(
      ChangeNotifierProvider<Application>(
        create: (BuildContext context) => Application(),
        builder: (context, child) {
          Application application =
              Provider.of<Application>(context, listen: true);
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
                  ImageVehicleSearchListPage(),
              Constants.ROUTE_VEHICLE_INFO_LOCATION: (context) =>
                  VehicleInfoLocationPage(),
              Constants.ROUTE_IMAGES_NEW_VEHICLE: (context) =>
                  ImagesNewVehiclePage(),
              Constants.ROUTE_IMAGES_HISTORY: (context) => ImagesHistoryPage(),
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
              Constants.ROUTE_IMAGES_CACHE_LOG: (context) =>
                  ImageCacheLogPage(),
              Constants.ROUTE_MOVEMENT_PROTOCOL_QUESTION_OVERVIEW: (context) =>
                  MovementProtocolQuestionOverviewPage(),
              Constants.ROUTE_MOVEMENT_PROTOCOL_PDF_PREVIEW: (context) =>
                  MovementProtocolPdfPreviewPage(),
            },
          );
        },
      ),
    );
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
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
