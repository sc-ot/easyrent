import 'package:devtools/sc_shared_prefs_storage.dart';
import 'package:easyrent/core/constants.dart';
import 'package:easyrent/widgets/menu_card_icon_text_widget.dart';
import 'package:easyrent/widgets/menu_page_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class MenuMovementPage extends StatelessWidget {
  final String title;
  final String subTitle;
  const MenuMovementPage(this.title, this.subTitle, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MenuPageContainer(
      title,
      subTitle,
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: MenuCardIconText(
                "Eingang",
                LineIcons.arrowDown,
                () => Navigator.pushNamed(
                    context, Constants.ROUTE_MOVEMENT_SEARCH_LIST,
                    arguments: Constants.MOVEMENT_TYPE_ENTRY),
                backgroundImage: SCSharedPrefStorage.readBool(
                                Constants.KEY_SHOW_IMAGES_IN_MENU) !=
                            null &&
                        SCSharedPrefStorage.readBool(
                            Constants.KEY_SHOW_IMAGES_IN_MENU)
                    ? "assets/menu_entrance.jpeg"
                    : null,
              ),
            ),
            Flexible(
              child: MenuCardIconText(
                "Ausgang",
                LineIcons.arrowUp,
                () => Navigator.pushNamed(
                    context, Constants.ROUTE_MOVEMENT_SEARCH_LIST,
                    arguments: Constants.MOVEMENT_TYPE_EXIT),
                backgroundImage: SCSharedPrefStorage.readBool(
                                Constants.KEY_SHOW_IMAGES_IN_MENU) !=
                            null &&
                        SCSharedPrefStorage.readBool(
                            Constants.KEY_SHOW_IMAGES_IN_MENU)
                    ? "assets/menu_exit.jpeg"
                    : null,
              ),
            ),
            Flexible(
              child: MenuCardIconText(
                "Geplante Bewegung",
                Icons.content_paste,
                () => Navigator.pushNamed(context,
                    Constants.ROUTE_MOVEMENT_PLANNED_MOVEMENT_SEARCH_LIST),
                backgroundImage: SCSharedPrefStorage.readBool(
                                Constants.KEY_SHOW_IMAGES_IN_MENU) !=
                            null &&
                        SCSharedPrefStorage.readBool(
                            Constants.KEY_SHOW_IMAGES_IN_MENU)
                    ? "assets/menu_planned_movement.png"
                    : null,
              ),
            ),
          ],
        ),
      ),
      paddingBottom: 16,
    );
  }
}
