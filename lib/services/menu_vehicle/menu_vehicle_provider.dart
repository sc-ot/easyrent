import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/models/vehicle.dart';
import 'package:easyrent/network/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class MenuVehicleProvider extends StateProvider {
  EasyRentRepository easyRentRepository = EasyRentRepository();
  StreamSubscription? vehicleStreamSubscription;
  StreamSubscription? internetConnectivitySubscription;
  TextEditingController vehicleSearchFieldController = TextEditingController();
  ScrollController scrollController = ScrollController();
  final PagingController<int, Vehicle> pagingController =
      PagingController(firstPageKey: 0);

  MenuVehicleProvider() {
    fetchVehicle(0);
    pagingController.addPageRequestListener((pageKey) {
      fetchVehicle(pageKey);
    });

    internetConnectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        pagingController.refresh();
      }
    });
  }

  void fetchVehicle(int pageKey, {bool isSearch = false}) {
    if (pageKey == 0) {
      setState(state: STATE.LOADING);
    }
    vehicleStreamSubscription?.cancel();

    vehicleStreamSubscription = easyRentRepository
        .getVehicles(pageKey, vehicleSearchFieldController.text)
        .asStream()
        .listen(
      (response) {
        if (isSearch) {
          pagingController.itemList = [];
          if (scrollController.hasClients) {
            scrollController.jumpTo(0);
          }
        }
        response.fold(
          (l) {
            pagingController.error = l;
            setState(state: STATE.ERROR);
          },
          (response) {
            setState(state: STATE.SUCCESS);
            List<Vehicle> newItems = List<Vehicle>.from(response);
            final isLastPage = newItems.length < 20;
            if (isLastPage) {
              pagingController.appendLastPage(newItems);
            } else {
              final nextPageKey = pageKey + 1;
              pagingController.appendPage(newItems, nextPageKey);
            }
          },
        );
        notifyListeners();
      },
    );
  }

  @override
  void dispose() {
    vehicleStreamSubscription?.cancel();
    internetConnectivitySubscription?.cancel();
    super.dispose();
  }
}
