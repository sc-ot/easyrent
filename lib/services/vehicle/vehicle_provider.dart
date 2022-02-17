import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/models/vehicle.dart';
import 'package:easyrent/network/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sc_appframework/models/failure.dart';

enum VEHICLELISTTYPE {
  STANDARD,
  MOVEMENT_VEHICLES_ENTRY,
  MOVEMENT_VEHICLES_EXIT,
}

class VehicleProvider extends StateProvider {
  EasyRentRepository easyRentRepository = EasyRentRepository();
  StreamSubscription? vehicleStreamSubscription;
  StreamSubscription? internetConnectivitySubscription;
  TextEditingController vehicleSearchFieldController = TextEditingController();
  ScrollController scrollController = ScrollController();
  VEHICLELISTTYPE listType;
  late Vehicle vehicle;
  late Function onPressed;
  final PagingController<int, Vehicle> pagingController =
      PagingController(firstPageKey: 0);

  String lastSearchedText = "-";

  VehicleProvider(this.listType, this.onPressed) {
    pagingController.addPageRequestListener(
      (pageKey) {
        fetchVehicle(pageKey, isPaging: true);
      },
    );

    internetConnectivitySubscription =
        Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        if (result == ConnectivityResult.mobile ||
            result == ConnectivityResult.wifi) {
          pagingController.refresh();
        }
      },
    );
  }

  void fetchVehicle(int pageKey,
      {bool isSearch = false, bool isPaging = false}) {
    if (lastSearchedText == vehicleSearchFieldController.text && !isPaging) {
      return;
    }

    lastSearchedText = vehicleSearchFieldController.text;

    if (pageKey == 0) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        setState(state: STATE.LOADING);
      });
    }
    vehicleStreamSubscription?.cancel();

    switch (listType) {
      case VEHICLELISTTYPE.STANDARD:
        vehicleStreamSubscription = easyRentRepository
            .getVehicles(pageKey, vehicleSearchFieldController.text)
            .asStream()
            .listen(
          (response) {
            handleResponse(response, isSearch, pageKey);
          },
        );
        break;

      case VEHICLELISTTYPE.MOVEMENT_VEHICLES_ENTRY:
        vehicleStreamSubscription = easyRentRepository
            .getAllVehiclesWithEntry(pageKey, vehicleSearchFieldController.text)
            .asStream()
            .listen(
          (response) {
            handleResponse(response, isSearch, pageKey);
          },
        );
        break;

      case VEHICLELISTTYPE.MOVEMENT_VEHICLES_EXIT:
        vehicleStreamSubscription = easyRentRepository
            .getAllVehiclesWithExit(pageKey, vehicleSearchFieldController.text)
            .asStream()
            .listen(
          (response) {
            handleResponse(response, isSearch, pageKey);
          },
        );
        break;
    }
  }

  void handleResponse(
      Either<Failure, dynamic> response, bool isSearch, int pageKey) {
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
  }

  @override
  void dispose() {
    vehicleStreamSubscription?.cancel();
    internetConnectivitySubscription?.cancel();
    super.dispose();
  }
}
