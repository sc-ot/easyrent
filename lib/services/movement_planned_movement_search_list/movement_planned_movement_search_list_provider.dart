import 'dart:async';

import 'package:easyrent/core/constants.dart';
import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/models/planned_movement.dart';
import 'package:easyrent/network/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlannedMovementViewData {
  StreamSubscription? subscription;
  List<PlannedMovement> plannedMovements;
  bool isExpanded;

  PlannedMovementViewData(
    this.subscription,
    this.plannedMovements,
    this.isExpanded,
  );
}

class MovementPlannedMovementSearchListProvider extends StateProvider  {
  EasyRentRepository easyRentRepository = EasyRentRepository();
  TextEditingController plannedMovementSearchFieldTextEditingController =
      TextEditingController();


  late PlannedMovement plannedMovement;
  late Function onPressed;

  Map<String, PlannedMovementViewData> plannedMovements = {};

  MovementPlannedMovementSearchListProvider() {
    plannedMovements.addAll({
      "entry_today": PlannedMovementViewData(
        null,
        [],
        false,
      ),
      "entry_past": PlannedMovementViewData(
        null,
        [],
        false,
      ),
      "entry_future": PlannedMovementViewData(
        null,
        [],
        false,
      ),
      "exit_today": PlannedMovementViewData(
        null,
        [],
        false,
      ),
      "exit_past": PlannedMovementViewData(
        null,
        [],
        false,
      ),
      "exit_future": PlannedMovementViewData(
        null,
        [],
        false,
      ),
    });

    getPlannedMovements(Constants.MOVEMENT_TYPE_ENTRY);
    getPlannedMovements(Constants.MOVEMENT_TYPE_EXIT);
  }

  int entrySuccessRequestsCounter = 3;
  int exitSuccessRequestsCounter = 3;
  int entryCurrentSuccessRequestCounter = 0;
  int exitCurrentSuccessRequestCounter = 0;

  String lastSearchedText = "";
  bool initPlannedMovements = true;


  int getMovementType(BuildContext context){
    return DefaultTabController.of(context)!.index;
  }

  void clearPlannedMovements() {
    for (var plannedMovementViewData in plannedMovements.values) {
      plannedMovementViewData.plannedMovements.clear();
    }
  }

  void clearEntrySubscrptions() {
    plannedMovements["entry_today"]!.subscription?.cancel();
    plannedMovements["entry_past"]!.subscription?.cancel();
    plannedMovements["entry_future"]!.subscription?.cancel();
  }

  void clearExitSubscrptions() {
    plannedMovements["exit_today"]!.subscription?.cancel();
    plannedMovements["exit_past"]!.subscription?.cancel();
    plannedMovements["exit_future"]!.subscription?.cancel();
  }

  void expandOrCloseHeader(int index, bool isExpanded, int movementType) {
    switch (movementType) {
      case Constants.MOVEMENT_TYPE_ENTRY:
        switch (index) {
          case 0:
          plannedMovements["entry_today"]!.isExpanded = isExpanded;
            break;
          case 1:
           plannedMovements["entry_past"]!.isExpanded = isExpanded;
            break;
          case 2:
           plannedMovements["entry_future"]!.isExpanded = isExpanded;
            break;
        }
        break;
      case Constants.MOVEMENT_TYPE_EXIT:
        switch (index) {
          case 0:
          plannedMovements["exit_today"]!.isExpanded = isExpanded;
            break;
          case 1:
           plannedMovements["exit_past"]!.isExpanded = isExpanded;
            break;
          case 2:
           plannedMovements["exit_future"]!.isExpanded = isExpanded;
            break;
        }
        break;
    }
    setState(state: STATE.PLANNED_MOVEMENT_EXIT_AND_ENTRY_LOADED);
  }

  void getPlannedMovements(
    int movementType,
  ) {
    lastSearchedText == plannedMovementSearchFieldTextEditingController.text;

    if (lastSearchedText ==
            plannedMovementSearchFieldTextEditingController.text &&
        !initPlannedMovements) {
      return;
    }

    setState(state: STATE.LOADING);

    entryCurrentSuccessRequestCounter = 0;
    exitCurrentSuccessRequestCounter = 0;

    if (movementType == Constants.MOVEMENT_TYPE_ENTRY) {
      clearEntrySubscrptions();
      plannedMovements["entry_future"]!.subscription = easyRentRepository
          .getPlannedMovementsForFuture(movementType,
              plannedMovementSearchFieldTextEditingController.text)
          .asStream()
          .listen(
        (response) {
          response.fold(
            (l) => null,
            (success) {
              entryCurrentSuccessRequestCounter++;
              plannedMovements["entry_future"]!.plannedMovements =
                  List<PlannedMovement>.from(success);

              checkIfAllPlannedMovementsLoaded();
            },
          );
        },
      );

      plannedMovements["entry_past"]!.subscription = easyRentRepository
          .getPlannedMovementsForPast(movementType,
              plannedMovementSearchFieldTextEditingController.text)
          .asStream()
          .listen(
        (response) {
          response.fold(
            (l) => null,
            (success) {
              entryCurrentSuccessRequestCounter++;
              plannedMovements["entry_past"]!.plannedMovements =
                  List<PlannedMovement>.from(success);

              checkIfAllPlannedMovementsLoaded();
            },
          );
        },
      );

      plannedMovements["entry_today"]!.subscription = easyRentRepository
          .getPlannedMovementsForToday(movementType,
              plannedMovementSearchFieldTextEditingController.text)
          .asStream()
          .listen(
        (response) {
          response.fold(
            (l) => null,
            (success) {
              entryCurrentSuccessRequestCounter++;
              plannedMovements["entry_today"]!.plannedMovements =
                  List<PlannedMovement>.from(success);

              checkIfAllPlannedMovementsLoaded();
            },
          );
        },
      );
    } else {
      clearExitSubscrptions();
      plannedMovements["exit_future"]!.subscription = easyRentRepository
          .getPlannedMovementsForFuture(movementType,
              plannedMovementSearchFieldTextEditingController.text)
          .asStream()
          .listen(
        (response) {
          response.fold(
            (l) => null,
            (success) {
              exitCurrentSuccessRequestCounter++;
              plannedMovements["exit_future"]!.plannedMovements =
                  List<PlannedMovement>.from(success);

              checkIfAllPlannedMovementsLoaded();
            },
          );
        },
      );

      plannedMovements["exit_past"]!.subscription = easyRentRepository
          .getPlannedMovementsForPast(movementType,
              plannedMovementSearchFieldTextEditingController.text)
          .asStream()
          .listen(
        (response) {
          response.fold(
            (l) => null,
            (success) {
              exitCurrentSuccessRequestCounter++;
              plannedMovements["exit_past"]!.plannedMovements =
                  List<PlannedMovement>.from(success);

              checkIfAllPlannedMovementsLoaded();
            },
          );
        },
      );

      plannedMovements["exit_today"]!.subscription = easyRentRepository
          .getPlannedMovementsForToday(movementType,
              plannedMovementSearchFieldTextEditingController.text)
          .asStream()
          .listen(
        (response) {
          response.fold(
            (l) => null,
            (success) {
              exitCurrentSuccessRequestCounter++;
              plannedMovements["exit_today"]!.plannedMovements =
                  List<PlannedMovement>.from(success);

              checkIfAllPlannedMovementsLoaded();
            },
          );
        },
      );
    }
  }

  void checkIfAllPlannedMovementsLoaded() {
    if (entrySuccessRequestsCounter == entryCurrentSuccessRequestCounter &&
        exitSuccessRequestsCounter == exitCurrentSuccessRequestCounter) {
      initPlannedMovements = false;

      plannedMovements["exit_today"]!.isExpanded =
          plannedMovements["exit_today"]!.plannedMovements.length > 0;
      plannedMovements["exit_past"]!.isExpanded =
          plannedMovements["exit_past"]!.plannedMovements.length > 0;
      plannedMovements["exit_future"]!.isExpanded =
          plannedMovements["exit_future"]!.plannedMovements.length > 0;
      plannedMovements["entry_today"]!.isExpanded =
          plannedMovements["entry_today"]!.plannedMovements.length > 0;
      plannedMovements["entry_past"]!.isExpanded =
          plannedMovements["entry_past"]!.plannedMovements.length > 0;
      plannedMovements["entry_future"]!.isExpanded =
          plannedMovements["entry_future"]!.plannedMovements.length > 0;

      setState(state: STATE.PLANNED_MOVEMENT_EXIT_AND_ENTRY_LOADED);
      return;
    }
  }

  @override
  void dispose() {
    clearEntrySubscrptions();
    clearExitSubscrptions();
    super.dispose();
  }
}
