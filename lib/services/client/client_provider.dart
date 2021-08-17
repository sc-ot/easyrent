import 'package:easyrent/core/constants.dart';
import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/network/repository.dart';
import 'package:flutter/material.dart';
import 'package:easyrent/models/client.dart';

class ClientProvider extends StateProvider {
  EasyRentRepository easyRentRepository = EasyRentRepository();
  List<Client> clients = [];

  ClientProvider() {
    loadClients();
  }
  void loadClients() {
    easyRentRepository.getClients().asStream().listen(
      (response) {
        response.fold(
          (failure) {
            ui = STATE.ERROR;
          },
          (response) {
            clients = List<Client>.from(response);
            ui = STATE.SUCCESS;
          },
        );
        notifyListeners();
      },
    );
  }

  void selectClient(BuildContext context, int clientIndex) {
    Navigator.popAndPushNamed(context, Constants.ROUTE_MENU);
  }
}
