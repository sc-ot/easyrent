import 'package:devtools/storage.dart';
import 'package:easyrent/core/application.dart';
import 'package:easyrent/core/constants.dart';
import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/services/menu_settings/menu_settings_page_settings_entry_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuSettingsProvider extends StateProvider {
  List<Widget> settings = [];

  MenuSettingsProvider(BuildContext context) {
    settings.add(
      SettingsEntry(
        "Vorlage bei Fahrzeugfotos anzeigen",
        Storage.readBool(Constants.KEY_SHOW_CAMERA_OVERLAY) ?? false,
        (value) {
          Storage.saveData(Constants.KEY_SHOW_CAMERA_OVERLAY, value);
        },
      ),
    );

    Application application = Provider.of<Application>(context, listen: false);
    settings.add(
      SettingsEntry(
        "Dunkelmodus aktivieren",
        application.themeMode == ThemeMode.dark ? true : false,
        (value) {
          Application application =
              Provider.of<Application>(context, listen: false);
          application.changeTheme();
        },
      ),
    );
  }
}
