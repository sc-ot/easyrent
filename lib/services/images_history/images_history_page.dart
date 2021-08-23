import 'package:easyrent/core/constants.dart';
import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/models/camera.dart';
import 'package:easyrent/services/camera/camera_page.dart';
import 'package:easyrent/services/images_new_vehicle/images_new_vehicle_provider.dart.dart';
import 'package:easyrent/services/menu_settings/menu_settings_page_settings_entry_widget.dart';
import 'package:easyrent/widgets/menu_page_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'images_history_provider.dart.dart';

class ImagesHistoryPage extends StatelessWidget {
  const ImagesHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ImagesHistoryProvider>(
      create: (context) => ImagesHistoryProvider(),
      builder: (context, child) {
        ImagesHistoryProvider imagesHistoryProvider =
            Provider.of<ImagesHistoryProvider>(context, listen: true);
        return Scaffold(
          appBar: AppBar(),
          body: MenuPageContainer(
            "Bilderhistorie",
            "Verlauf aufgenommener Bilder",
            Column(
              children: [
                SettingsEntry("Test"),
              ],
            ),
          ),
        );
      },
    );
  }
}
