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
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: MenuCardIconText(
              "Eingang",
              LineIcons.arrowDown,
              () => Navigator.pushNamed(
                  context, Constants.ROUTE_MOVEMENT_SEARCH_LIST,
                  arguments: Constants.MOVEMENT_TYPE_ENTRY),
            ),
          ),
          Flexible(
            child: MenuCardIconText(
              "Ausgang",
              LineIcons.arrowUp,
              () => Navigator.pushNamed(
                  context, Constants.ROUTE_MOVEMENT_SEARCH_LIST,
                  arguments: Constants.MOVEMENT_TYPE_EXIT),
            ),
          ),
          Flexible(
            child: MenuCardIconText(
              "Geplante Bewegung",
              Icons.content_paste,
              () => Navigator.pushNamed(context,
                  Constants.ROUTE_MOVEMENT_PLANNED_MOVEMENT_SEARCH_LIST),
            ),
          ),
        ],
      ),
      paddingBottom: 16,
    );
  }
}
