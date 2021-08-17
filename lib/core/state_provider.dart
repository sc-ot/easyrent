import 'package:flutter/cupertino.dart';

class StateProvider extends ChangeNotifier {
  STATE ui = STATE.IDLE;

 void setState({STATE state = STATE.IDLE}){
    ui = state;
    notifyListeners();
 }
}

enum STATE { IDLE, LOADING, ERROR, SUCCESS }
