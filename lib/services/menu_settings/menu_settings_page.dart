import 'package:easyrent/core/authenticator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/menu_page_container_widget.dart';
import 'menu_settings_provider.dart';

class MenuSettingsPage extends StatelessWidget {
  final title;
  final subTitle;
  const MenuSettingsPage(this.title, this.subTitle, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MenuSettingsProvider>(
      create: (context) => MenuSettingsProvider(context),
      builder: (context, child) {
        MenuSettingsProvider menuSettingsProvider =
            Provider.of<MenuSettingsProvider>(context, listen: true);
        return Scaffold(
          floatingActionButton: FloatingActionButton.extended(
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
          body: MenuPageContainer(
            title,
            subTitle,
            ListView.builder(
              itemBuilder: (context, index) {
                return menuSettingsProvider.settings[index];
              },
              itemCount: menuSettingsProvider.settings.length,
            ),
          ),
        );
      },
    );
  }
}
