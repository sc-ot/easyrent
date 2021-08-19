import 'package:flutter/material.dart';

import '../../../widgets/menu_page_container_widget.dart';
import 'menu_settings_page_settings_entry_widget.dart';

class MenuSettingsPage extends StatelessWidget {
  final title;
  final subTitle;
  const MenuSettingsPage(this.title, this.subTitle, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MenuPageContainer(
      title,
      subTitle,
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SettingsEntry("Vorlage bei Fahrzeugfotos anzeigen"),
          SettingsEntry("Vorlage bei Fahrzeugfotos anzeigen"),
          SettingsEntry("Vorlage bei Fahrzeugfotos anzeigen"),
          SettingsEntry("Vorlage bei Fahrzeugfotos anzeigen"),
        ],
      ),
    );
  }
}
