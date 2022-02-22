import 'package:easyrent/core/constants.dart';
import 'package:easyrent/core/themes.dart';
import 'package:easyrent/models/client.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_appframework/storage/sc_shared_prefs_storage.dart';

class Application with ChangeNotifier {
  static GlobalKey globalKey = GlobalKey();
  ThemeMode themeMode = ThemeMode.light;
  late Client client;
  List<Client> clients = [];

  Application() {
    loadCurrentTheme();
  }

  void changeToDarkTheme() {
    themeMode = ThemeMode.dark;
    SCSharedPrefStorage.saveData(Constants.KEY_THEME, 1);
    notifyListeners();
  }

  void changeAppAccentColor(Color color) {
    Themes.accentColor = color;
    Themes.darkAccentColor = color;
    notifyListeners();
  }

  void changeToLightTheme() {
    themeMode = ThemeMode.light;
    SCSharedPrefStorage.saveData(Constants.KEY_THEME, 0);
    notifyListeners();
  }

  void loadCurrentTheme() {
    if (SCSharedPrefStorage.readInt(Constants.KEY_THEME) == null ||
        SCSharedPrefStorage.readInt(Constants.KEY_THEME) == 0) {
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
