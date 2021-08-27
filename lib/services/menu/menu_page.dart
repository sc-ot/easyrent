import 'package:easyrent/core/constants.dart';
import 'package:easyrent/core/utils.dart';
import 'package:easyrent/services/menu/menu_provider.dart';

import 'package:easyrent/services/menu_images/menu_images_page.dart';
import 'package:easyrent/services/menu_movement/menu_movement_page.dart';
import 'package:easyrent/services/menu_settings/menu_settings_page.dart';
import 'package:easyrent/services/menu_vehicle/menu_vehicle_page.dart';
import 'package:easyrent/services/vehicle/vehicle_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class MenuData {
  final String text;
  final IconData icon;

  MenuData(this.text, this.icon);
}

class MenuPage extends StatelessWidget {
  MenuPage({Key? key}) : super(key: key);

  final List<MenuData> menu = [
    MenuData("Übergabe", LineIcons.fileUpload),
    MenuData("Fahrzeug", LineIcons.car),
    MenuData("Fotos", LineIcons.camera),
    MenuData("Einstellungen", LineIcons.cog),
  ];

  List<GButton> menuButtons = [];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MenuProvider>(
          create: (_) => MenuProvider(),
        ),
        ChangeNotifierProvider<VehicleProvider>(
          create: (_) => VehicleProvider(
            VEHICLELISTTYPE.STANDARD,
            () => Navigator.pushNamed(context, Constants.ROUTE_VEHICLE_INFO),
          ),
        ),
      ],
      builder: (context, child) {
        MenuProvider menuProvider =
            Provider.of<MenuProvider>(context, listen: true);
        menuButtons = List.generate(
          menu.length,
          (index) => GButton(
            onPressed: () {
              menuProvider.bottomBarTab(index);
            },
            gap: 12,
            icon: menu[index].icon,
            iconColor: Theme.of(context).accentColor,
            iconActiveColor: Theme.of(context).accentColor,
            text: menu[index].text,
            textColor: Theme.of(context).textTheme.headline5!.color,
            backgroundColor:
                Theme.of(context).primaryColorDark.withOpacity(0.2),
            iconSize: 24,
            padding: EdgeInsets.all(
                Utils.getDevice(context) == Device.PHONE ? 8 : 16),
          ),
        );
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Column(
                children: [
                  Expanded(
                    flex: Utils.getDevice(context) == Device.PHONE ? 9 : 13,
                    child: PageView(
                      controller: menuProvider.pageController,
                      onPageChanged: (index) {
                        menuProvider.swipe(index);
                      },
                      children: [
                        MenuMovementPage(
                          "Übergabe",
                          "Eingang oder Ausgang ausführen",
                        ),
                        MenuVehiclePage(
                          "Fahrzeug",
                          "Fahrzeuginformationen anzeigen",
                        ),
                        MenuImagesPage(
                          "Fotos",
                          "Fahrzeugfotos aufnehmen und hochladen",
                        ),
                        MenuSettingsPage(
                          "Einstellungen",
                          "Universelle App-Einstellungen",
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 1.0,
                            ),
                          ],
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          color: Theme.of(context).primaryColorLight,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 16.0,
                            right: 16,
                          ),
                          child: GNav(
                              selectedIndex: menuProvider.currentMenuIndex,
                              curve: Curves.easeIn,
                              tabs: menuButtons),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
