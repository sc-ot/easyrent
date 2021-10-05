import 'package:devtools/sc_shared_prefs_storage.dart';
import 'package:easyrent/core/application.dart';
import 'package:easyrent/core/authenticator.dart';
import 'package:easyrent/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/menu_page_container_widget.dart';
import 'menu_settings_page_settings_entry_widget.dart';
import 'menu_settings_provider.dart';

class MenuSettingsPage extends StatelessWidget {
  final title;
  final subTitle;
  const MenuSettingsPage(this.title, this.subTitle, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MenuSettingsProvider>(
      create: (context) => MenuSettingsProvider(),
      builder: (context, child) {
        List<Widget> settings = [];

        settings.add(
          SettingsEntry(
            "Vorlage bei Fahrzeugfotos anzeigen",
            SCSharedPrefStorage.readBool(Constants.KEY_SHOW_CAMERA_OVERLAY) ??
                false,
            (value) {
              SCSharedPrefStorage.saveData(
                  Constants.KEY_SHOW_CAMERA_OVERLAY, value);
            },
          ),
        );

        Application application =
            Provider.of<Application>(context, listen: false);
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

        settings.add(
          SettingsEntry(
            "Bilder lokal speichern",
            SCSharedPrefStorage.readBool(Constants.KEY_SAVE_IMAGES_ON_DEVICE) !=
                    null
                ? true
                : false,
            (value) {
              SCSharedPrefStorage.saveData(
                  Constants.KEY_SAVE_IMAGES_ON_DEVICE, value);
            },
          ),
        );

        settings.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.popAndPushNamed(
                  context,
                  Constants.ROUTE_CLIENTS,
                );
              },
              backgroundColor: Theme.of(context).colorScheme.secondary,
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              label: Text(
                "Mandanten wechseln",
                style: Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        );

        settings.add(
          FloatingActionButton.extended(
            onPressed: () {
              Authenticator.logout(context);
            },
            backgroundColor: Colors.red,
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            label: Text(
              "Abmelden",
              style: Theme.of(context)
                  .textTheme
                  .button!
                  .copyWith(color: Colors.white),
            ),
          ),
        );

        MenuSettingsProvider menuSettingsProvider =
            Provider.of<MenuSettingsProvider>(context, listen: true);
        return Scaffold(
          body: MenuPageContainer(
            title,
            subTitle,
            ListView.builder(
              itemBuilder: (context, index) {
                return settings[index];
              },
              itemCount: settings.length,
            ),
          ),
        );
      },
    );
  }
}
