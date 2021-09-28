import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/core/utils.dart';
import 'package:easyrent/widgets/loading_indicator.dart';
import 'package:easyrent/widgets/menu_page_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'images_log_provider.dart';

class ImagesLogPage extends StatelessWidget {
  const ImagesLogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ImageLogProvider>(
      create: (context) => ImageLogProvider(),
      builder: (context, child) {
        ImageLogProvider imageLogProvider =
            Provider.of<ImageLogProvider>(context, listen: true);

        return Scaffold(
          appBar: AppBar(),
          body: MenuPageContainer(
            "Bilderhistorie",
            "Verlauf aufgenommener Bilder",
            imageLogProvider.ui == STATE.LOADING ||
                    imageLogProvider.ui == STATE.IDLE
                ? Center(
                    child: ERLoadingIndicator(),
                  )
                : ListView.separated(
                    itemCount: imageLogProvider.imageUploadGroups.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: ListTile(
                          trailing: Text(
                            imageLogProvider
                                .imageUploadGroups[index].vehicleNumber,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                          ),
                          leading: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  imageLogProvider
                                      .imageUploadGroups[index].takenPictures
                                      .toString(),
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Text("Bilder"),
                              ],
                            ),
                          ),
                          title: Text(
                              imageLogProvider.imageUploadGroups[index].vin,
                              style: Theme.of(context).textTheme.subtitle1),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                imageLogProvider
                                    .imageUploadGroups[index].firstName,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                              ),
                              Text(
                                Utils.formatDateTimestringWithTime(
                                  imageLogProvider
                                      .imageUploadGroups[index].createdAt,
                                ),
                                style: Theme.of(context).textTheme.subtitle2!,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                  ),
          ),
        );
      },
    );
  }
}
