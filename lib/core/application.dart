import 'package:devtools/storage.dart';
import 'package:easyrent/core/constants.dart';
import 'package:easyrent/core/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Application with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  Application() {
    loadCurrentTheme();
  }

  void changeToDarkTheme() {
    themeMode = ThemeMode.dark;
    Storage.saveData(Constants.KEY_THEME, 1);
    notifyListeners();
  }

  void changeToLightTheme() {
    themeMode = ThemeMode.light;
    Storage.saveData(Constants.KEY_THEME, 0);
    notifyListeners();
  }

  void loadCurrentTheme() {
    if (Storage.readInt(Constants.KEY_THEME) == null ||
        Storage.readInt(Constants.KEY_THEME) == 0) {
      changeToLightTheme();
    } else {
      changeToDarkTheme();
    }
  }

  void changeTheme() {
    if (themeMode == ThemeMode.dark) {
      changeToLightTheme();
    } else {
      changeToDarkTheme();
    }
  }
}
