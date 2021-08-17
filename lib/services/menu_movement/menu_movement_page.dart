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
          children: [
            Spacer(),
            MenuCardIconText("Eingang", LineIcons.arrowUp),
            Spacer(),
            MenuCardIconText("Ausgang", LineIcons.arrowDown),
            Spacer(),
          ],
        ),
    );
  }
}
