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
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: Colors.red,
        icon: Icon(Icons.exit_to_app, color: Colors.white, ),
        label: Text("Abmelden", style: Theme.of(context).textTheme.button,),
      ),
      body: MenuPageContainer(
        title,
        subTitle,
        Column(
          children: [
            SettingsEntry("Vorlage bei Fahrzeugfotos anzeigen"),
            SettingsEntry("Dunkelmodus aktivieren"),
            SettingsEntry("App automatisch aktualisieren"),
          ],
        ),
      ),
    );
  }
}
