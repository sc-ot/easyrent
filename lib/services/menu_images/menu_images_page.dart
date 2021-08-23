import 'package:easyrent/core/constants.dart';
import 'package:easyrent/services/camera/camera_page.dart';
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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.list),
        onPressed: () {
          Navigator.pushNamed(context, Constants.ROUTE_IMAGES_HISTORY);
        },
      ),
      body: MenuPageContainer(
        title,
        subTitle,
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: MenuCardIconText(
                  "Vorhanden",
                  LineIcons.list,
                  () => Navigator.pushNamed(
                      context, Constants.ROUTE_CAMERA_VEHICLE_SEARCH_LIST,
                      arguments: CameraType.VEHICLE),
                ),
              ),
              Flexible(
                child: MenuCardIconText(
                  "Neu",
                  LineIcons.camera,
                  () => Navigator.pushNamed(
                      context, Constants.ROUTE_IMAGES_NEW_VEHICLE,
                      arguments: CameraType.NEW_VEHICLE),
                ),
              ),
              Flexible(
                child: MenuCardIconText(
                  "Unfall",
                  LineIcons.exclamationCircle,
                  () => Navigator.pushNamed(
                      context, Constants.ROUTE_CAMERA_VEHICLE_SEARCH_LIST,
                      arguments: CameraType.ACCIDENT_VEHICLE),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
