import 'package:devtools/sc_shared_prefs_storage.dart';
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
    return MenuPageContainer(
      title,
      subTitle,
      Expanded(
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
                backgroundImage: SCSharedPrefStorage.readBool(
                                Constants.KEY_SHOW_IMAGES_IN_MENU) !=
                            null &&
                        SCSharedPrefStorage.readBool(
                            Constants.KEY_SHOW_IMAGES_IN_MENU)
                    ? "assets/menu_image_exist.jpg"
                    : null,
              ),
            ),
            Flexible(
              child: MenuCardIconText(
                "Neu",
                LineIcons.camera,
                () => Navigator.pushNamed(
                    context, Constants.ROUTE_IMAGES_NEW_VEHICLE,
                    arguments: CameraType.NEW_VEHICLE),
                backgroundImage: SCSharedPrefStorage.readBool(
                                Constants.KEY_SHOW_IMAGES_IN_MENU) !=
                            null &&
                        SCSharedPrefStorage.readBool(
                            Constants.KEY_SHOW_IMAGES_IN_MENU)
                    ? "assets/menu_image_new.jpeg"
                    : null,
              ),
            ),
            Flexible(
              child: MenuCardIconText(
                "Unfall",
                LineIcons.exclamationCircle,
                () => null,
                backgroundImage: SCSharedPrefStorage.readBool(
                                Constants.KEY_SHOW_IMAGES_IN_MENU) !=
                            null &&
                        SCSharedPrefStorage.readBool(
                            Constants.KEY_SHOW_IMAGES_IN_MENU)
                    ? "assets/accident.jpeg"
                    : null,
              ),
            ),
          ],
        ),
      ),
      paddingBottom: 16,
      floatingActionButton: FloatingActionButton(
        heroTag: "logImageFab",
        child: Icon(
          Icons.list,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pushNamed(context, Constants.ROUTE_IMAGES_LOG_PAGE);
        },
      ),
    );
  }
}
