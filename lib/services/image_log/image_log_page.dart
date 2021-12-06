import 'package:easyrent/core/constants.dart';
import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/core/themes.dart';
import 'package:easyrent/core/utils.dart';
import 'package:easyrent/widgets/loading_indicator.dart';
import 'package:easyrent/widgets/menu_page_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'image_log_provider.dart';

class ImagesLogPage extends StatelessWidget {
  const ImagesLogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ImageLogProvider>(
      create: (context) => ImageLogProvider(),
      builder: (context, child) {
        ImageLogProvider imageLogProvider =
            Provider.of<ImageLogProvider>(context, listen: true);

        return MenuPageContainer(
          "Bilderhistorie",
          "Verlauf aufgenommener Bilder",
          imageLogProvider.ui == STATE.LOADING ||
                  imageLogProvider.ui == STATE.IDLE
              ? Expanded(
                  child: Center(
                    child: ERLoadingIndicator(),
                  ),
                )
              : Expanded(
                  child: RefreshIndicator(
                    color: Colors.white,
                    backgroundColor: Themes.accentColor,
                    onRefresh: () {
                      imageLogProvider.loadImages();
                      return Future.value();
                    },
                    child: ListView.separated(
                      itemCount: imageLogProvider.imageUploadGroups.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 3,
                          color: Theme.of(context).primaryColorLight,
                          child: InkWell(
                            onTap: () async {
                              Navigator.pushNamed(
                                  context, Constants.ROUTE_IMAGES_CACHE_LOG,
                                  arguments: imageLogProvider
                                      .imageUploadGroups[index]
                                      .imageUploadGroupProcessId);
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 10,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          imageLogProvider
                                              .imageUploadGroups[index]
                                              .firstName,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          imageLogProvider
                                                  .imageUploadGroups[index]
                                                  .vin
                                                  .isEmpty
                                              ? "Neues Fahrzeug"
                                              : imageLogProvider
                                                  .imageUploadGroups[index].vin,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                          overflow: TextOverflow.fade,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          Utils.formatDateTimestringWithTime(
                                            imageLogProvider
                                                .imageUploadGroups[index]
                                                .createdAt,
                                          ),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                          overflow: TextOverflow.fade,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          imageLogProvider
                                              .imageUploadGroups[index]
                                              .vehicleNumber,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                            "${imageLogProvider.imageUploadGroups[index].takenPictures == -1 ? "-" : imageLogProvider.imageUploadGroups[index].takenPictures.toString()}" +
                                                "/" +
                                                "${imageLogProvider.imageUploadGroups[index].imagesCount == -1 ? "-" : imageLogProvider.imageUploadGroups[index].imagesCount.toString()}" +
                                                " Bilder",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1!),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Container();
                      },
                    ),
                  ),
                ),
          appBar: AppBar(),
        );
      },
    );
  }
}
