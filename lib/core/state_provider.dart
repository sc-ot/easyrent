import 'package:flutter/cupertino.dart';

class StateProvider extends ChangeNotifier {
  STATE ui = STATE.IDLE;

  bool disposed = false;

  void setState({STATE state = STATE.IDLE}) {
    if (!disposed) {
      ui = state;

      notifyListeners();
    }
  }

  @override
  void dispose() {
    disposed = true;
    super.dispose();
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
  IMAGE_CACHE_LOG_NO_IMAGES,
}
