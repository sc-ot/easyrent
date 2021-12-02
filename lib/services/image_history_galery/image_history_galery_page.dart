import 'dart:io';

import 'package:easyrent/widgets/menu_page_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:provider/provider.dart';

import 'image_history_galery_provider.dart';

class ImagesHistoryGaleryPage extends StatelessWidget {
  const ImagesHistoryGaleryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ImagesHistoryGaleryProvider>(
      create: (context) => ImagesHistoryGaleryProvider(),
      builder: (context, child) {
        final args = ModalRoute.of(context)!.settings.arguments;
        List<String> imagePaths = args as List<String>;
        ImagesHistoryGaleryProvider imagesHistoryGaleryProvider =
            Provider.of<ImagesHistoryGaleryProvider>(context, listen: true);

        return MenuPageContainer(
          "Galerie",
          "Aufgenommene Bilder",
          GridView.count(
            shrinkWrap: true,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            crossAxisCount: 2,
            children: List.generate(
              imagePaths.length,
              (index) => FullScreenWidget(
                disposeLevel: DisposeLevel.Low,
                child: Hero(
                  tag: "fullScreenImage" + index.toString(),
                  child: Image.file(
                    File(imagePaths[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          appBar: AppBar(),
        );
      },
    );
  }
}
