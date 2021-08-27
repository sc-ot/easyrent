import 'package:flutter/cupertino.dart';

class StateProvider extends ChangeNotifier {
  STATE ui = STATE.IDLE;

  void setState({STATE state = STATE.IDLE}) {
    ui = state;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
}

enum STATE {
  IDLE,
  LOADING,
  ERROR,
  SUCCESS,
  PLANNED_MOVEMENT_ENTRY_LOADED,
  PLANNED_MOVEMENT_EXIT_LOADED,
  PLANNED_MOVEMENT_EXIT_AND_ENTRY_LOADED,
}
