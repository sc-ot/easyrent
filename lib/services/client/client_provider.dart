import 'dart:async';
import 'dart:convert';

import 'package:easyrent/core/application.dart';
import 'package:easyrent/core/constants.dart';
import 'package:easyrent/core/state_provider.dart';

import 'package:easyrent/network/repository.dart';
import 'package:flutter/material.dart';
import 'package:easyrent/models/client.dart';
import 'package:provider/provider.dart';
import 'package:sc_appframework/storage/sc_shared_prefs_storage.dart';

class ClientProvider extends StateProvider {
  EasyRentRepository easyRentRepository = EasyRentRepository();
  StreamSubscription? clientSubscription;
  List<Client> clients = [];

  ClientProvider(BuildContext context) {
    loadClients(context);
  }
  void loadClients(BuildContext context) {
    clientSubscription?.cancel();
    clientSubscription = easyRentRepository.getClients().asStream().listen(
      (response) {
        response.fold(
          (failure) {
            ui = STATE.ERROR;
          },
          (response) async {
            Application application =
                Provider.of<Application>(context, listen: false);
            clients = List<Client>.from(response);
            var result = jsonEncode(clients);
            await SCSharedPrefStorage.saveData(Constants.KEY_CLIENTS, result);
            application.clients = clients;
            ui = STATE.SUCCESS;
            notifyListeners();
          },
        );
      },
    );
  }

  void selectClient(BuildContext context, int clientIndex) {
    Constants.BASE_URL = clients[clientIndex].backendUrl;
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
