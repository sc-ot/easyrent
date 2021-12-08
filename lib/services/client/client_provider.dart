import 'dart:async';
import 'dart:io';

import 'package:easyrent/core/application.dart';
import 'package:easyrent/core/constants.dart';
import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/core/themes.dart';
import 'package:easyrent/core/utils.dart';
import 'package:easyrent/models/fleet_vehicle_image.dart';
import 'package:easyrent/network/repository.dart';
import 'package:flutter/material.dart';
import 'package:easyrent/models/client.dart';
import 'package:provider/provider.dart';
import 'package:sc_appframework/network/sc_cache_request_handler.dart';
import 'package:sc_appframework/network/sc_network_api.dart';

class ClientProvider extends StateProvider {
  EasyRentRepository easyRentRepository = EasyRentRepository();
  StreamSubscription? clientSubscription;
  List<Client> clients = [];

  ClientProvider() {
    loadClients();
  }
  void loadClients() {
    clientSubscription?.cancel();
    clientSubscription = easyRentRepository.getClients().asStream().listen(
      (response) {
        response.fold(
          (failure) {
            ui = STATE.ERROR;
          },
          (response) async {
            clients = List<Client>.from(response);
            List<SCCachedRequest> cachedRequests =
                SCNetworkApi().cachedRequests;

            for (int i = 0; i < SCNetworkApi().cachedRequests.length; i++) {
              if (SCNetworkApi().cachedRequests[i].method == Method.MULTIPART &&
                  SCNetworkApi().cachedRequests[i].filePayload != null) {
                var result = await easyRentRepository.checkIfImageExists(
                    SCNetworkApi()
                        .cachedRequests[i]
                        .filePayload!
                        .filePath
                        .split("/")
                        .last);

                result.fold(
                  (l) {},
                  (response) {
                    response = response as FleetVehicleImage;
                    if (response.id != 0) {
                      cachedRequests.removeAt(i);
                    }
                  },
                );
              }
            }
            SCNetworkApi().cachedRequests = cachedRequests;
            await SCNetworkApi().serializeRequests();
            SCNetworkApi().deSerializeRequests(start: true);

            ui = STATE.SUCCESS;
            notifyListeners();
          },
        );
      },
    );
  }

  void selectClient(BuildContext context, int clientIndex) {
    //Constants.BASE_URL = clients[clientIndex].backendUrl;

    Application application = Provider.of<Application>(context, listen: false);

    application.client = clients[clientIndex];
    application.changeAppAccentColor(
      getColorForTheme(application.client.theme),
    );
    Navigator.popAndPushNamed(context, Constants.ROUTE_MENU);
  }

  Color getColorForTheme(String theme) {
    switch (theme) {
      case Constants.THEME_1:
        return Color(0xFFff9800);
      case Constants.THEME_2:
        return Color(0xFF2196f3);
      case Constants.THEME_MARGARITIS:
        return Color(0xFFff9800);
      default:
        return Color(0xFFff9800);
    }
  }

  @override
  void dispose() {
    clientSubscription?.cancel();

    super.dispose();
  }
}
