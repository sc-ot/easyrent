import 'package:easyrent/widgets/menu_card_icon_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../../widgets/menu_page_container_widget.dart';

class MenuImagesPage extends StatelessWidget {
  final String title;
  final String subTitle;

  const MenuImagesPage(this.title, this.subTitle, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MenuPageContainer(
      title,
      subTitle,
      Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MenuCardIconText("Vorhanden", LineIcons.truck),
            MenuCardIconText("Neu", LineIcons.plus),
            MenuCardIconText("Unfall", LineIcons.exclamationTriangle),
          ],
        ),
      ),
    );
  }
}

