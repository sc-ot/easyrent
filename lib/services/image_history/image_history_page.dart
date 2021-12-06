import 'package:easyrent/core/constants.dart';
import 'package:easyrent/core/utils.dart';
import 'package:easyrent/widgets/menu_page_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'image_history_provider.dart';

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
              imagesHistoryProvider.imageHistory.isEmpty
                  ? Center(
                      child: Text(
                        "Es wurden keine Fahrzeugfotos aufgenommen. Bitte nehmen Sie Fotos auf, um Sie im Verlauf anzuzeigen",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        String trailingDescription = imagesHistoryProvider
                                    .imageHistory[index].imagePaths.length ==
                                1
                            ? "Bild wurde aufgenommen"
                            : "Bilder wurden aufgenommen";
                        if (imagesHistoryProvider.imageHistory[index].vehicle !=
                            null) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(context,
                                  Constants.ROUTE_IMAGES_HISTORY_GALERY,
                                  arguments: imagesHistoryProvider
                                      .imageHistory[index].imagePaths);
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                              child: ListTile(
                                leading: FittedBox(
                                  child: Text(
                                    imagesHistoryProvider
                                            .imageHistory[index].client
                                            .contains("Easy")
                                        ? "ER"
                                        : imagesHistoryProvider
                                            .imageHistory[index].client,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                                title: Text(
                                    imagesHistoryProvider.imageHistory[index]
                                        .vehicle!.licensePlate,
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      imagesHistoryProvider
                                          .imageHistory[index].vehicle!.vin,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary),
                                    ),
                                    Text(
                                        imagesHistoryProvider
                                            .imageHistory[index].date,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!),
                                  ],
                                ),
                                trailing:
                                    Utils.getDevice(context) == Device.TABLET
                                        ? Text(
                                            imagesHistoryProvider
                                                    .imageHistory[index]
                                                    .imagePaths
                                                    .length
                                                    .toString() +
                                                " " +
                                                trailingDescription,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1)
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  imagesHistoryProvider
                                                      .imageHistory[index]
                                                      .imagePaths
                                                      .length
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1),
                                              Text(
                                                "Bilder",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2,
                                              ),
                                            ],
                                          ),
                              ),
                            ),
                          );
                        } else {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(context,
                                  Constants.ROUTE_IMAGES_HISTORY_GALERY,
                                  arguments: imagesHistoryProvider
                                      .imageHistory[index].imagePaths);
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                              child: ListTile(
                                leading: Text(
                                  index.toString(),
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                title: Text("Neues Fahrzeug",
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      imagesHistoryProvider
                                          .imageHistory[index].vin!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .accentColor),
                                    ),
                                    Text(
                                        imagesHistoryProvider
                                            .imageHistory[index].date,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!),
                                  ],
                                ),
                                trailing: Text(
                                    imagesHistoryProvider.imageHistory[index]
                                            .imagePaths.length
                                            .toString() +
                                        " " +
                                        trailingDescription,
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                              ),
                            ),
                          );
                        }
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: imagesHistoryProvider.imageHistory.length)),
        );
      },
    );
  }
}
