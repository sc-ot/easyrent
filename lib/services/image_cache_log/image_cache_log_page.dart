import 'dart:io';

import 'package:easyrent/widgets/menu_page_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:provider/provider.dart';

import 'image_cache_log_provider.dart';

class ImageCacheLogPage extends StatelessWidget {
  const ImageCacheLogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ImageCacheLogProvider>(
      create: (context) => ImageCacheLogProvider(),
      builder: (context, child) {
        ImageCacheLogProvider imageCacheLogProvider =
            Provider.of<ImageCacheLogProvider>(context, listen: true);

        return MenuPageContainer(
          "Bilder",
          "Nicht hochgeladene Bilder",
          Expanded(
            child: Container(),
          ),
          appBar: AppBar(),
        );
      },
    );
  }
}
