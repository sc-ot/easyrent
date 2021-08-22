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

enum STATE { IDLE, LOADING, ERROR, SUCCESS }
