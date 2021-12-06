import 'dart:io';

import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/core/utils.dart';
import 'package:easyrent/services/camera/camera_page.dart';
import 'package:easyrent/widgets/loading_indicator.dart';
import 'package:easyrent/widgets/menu_page_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:provider/provider.dart';

import 'image_cache_log_provider.dart';

// TODO Doppelte Request nicht erlauben, Ui Error wenn man zu viele anklickt, Bilder nur für entsprechene processId anzeigen ordnerstruktur mit ids!!

class ImageCacheLogPage extends StatelessWidget {
  const ImageCacheLogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int uploadGroupId = ModalRoute.of(context)!.settings.arguments as int;
    return ChangeNotifierProvider<ImageCacheLogProvider>.value(
      value: ImageCacheLogProvider(uploadGroupId),
      builder: (context, child) {
        ImageCacheLogProvider imageCacheLogProvider =
            Provider.of<ImageCacheLogProvider>(context, listen: true);

        return MenuPageContainer(
          "Bilder",
          "Nicht hochgeladene Bilder",
          imageCacheLogProvider.ui == STATE.ERROR ||
                  imageCacheLogProvider.ui == STATE.IMAGE_CACHE_LOG_NO_IMAGES
              ? Expanded(
                  child: Center(
                    child: Text("Es wurden keine Bilder gefunden"),
                  ),
                )
              : imageCacheLogProvider.ui != STATE.SUCCESS
                  ? Center(
                      child: ERLoadingIndicator(),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: imageCacheLogProvider.keys.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          String title = "";

                          title = imageCacheLogProvider.keys[index]["vin"] +
                              " " +
                              imageCacheLogProvider.keys[index]["tag"];

                          return Column(
                            children: [
                              ListTile(
                                leading: Container(
                                  width: 20,
                                  child: FullScreenWidget(
                                    disposeLevel: DisposeLevel.High,
                                    child: Hero(
                                      tag: "fullScreenImage" + index.toString(),
                                      child: Image.file(
                                        File(imageCacheLogProvider.keys[index]
                                            ["path"]),
                                      ),
                                    ),
                                  ),
                                ),
                                title: Text(title),
                                subtitle: Text(
                                  Utils.formatDateTimestringWithTime(
                                    (imageCacheLogProvider.keys[index]["date"]
                                            as DateTime)
                                        .toIso8601String(),
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.send),
                                  onPressed: imageCacheLogProvider.keys[index]
                                          ["uploading"]
                                      ? null
                                      : () {
                                          imageCacheLogProvider.uploadImage(
                                              imageCacheLogProvider
                                                  .keys[index]);
                                        },
                                ),
                              ),
                              imageCacheLogProvider.keys[index]["uploading"]
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: LinearProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : Container(),
                            ],
                          );
                        },
                      ),
                    ),
          appBar: AppBar(),
        );
      },
    );
  }
}
