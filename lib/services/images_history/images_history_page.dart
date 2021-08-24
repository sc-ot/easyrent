import 'package:easyrent/core/utils.dart';
import 'package:easyrent/models/image_history.dart';
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

        List<Widget> entries = [];
        int index = 1;
        for (var historyEntry in imagesHistoryProvider.imageHistory) {
          String trailingDescription = historyEntry.imagePaths.length == 1
              ? "Bild wurde aufgenommen"
              : "Bilder wurden aufgenommen";
          if (historyEntry.vehicle != null) {
            entries.add(
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: ListTile(
                  onTap: () {},
                  leading: Text(
                    index.toString(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  title: Text(historyEntry.vehicle!.licensePlate,
                      style: Theme.of(context).textTheme.subtitle1),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        historyEntry.vehicle!.vin,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(color: Theme.of(context).accentColor),
                      ),
                         Text(historyEntry.date,
                          style: Theme.of(context).textTheme.subtitle2!),
                    ],
                  ),
                  trailing: Text(
                      historyEntry.imagePaths.length.toString() +
                          " " +
                          trailingDescription,
                      style: Theme.of(context).textTheme.subtitle1),
                ),
              ),
            );
          } else {
            entries.add(
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: ListTile(
                  onTap: () {},
                  leading: Text(
                    index.toString(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  title: Text("Neues Fahrzeug",
                      style: Theme.of(context).textTheme.subtitle1),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        historyEntry.vin!,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(color: Theme.of(context).accentColor),
                      ),
                      Text(historyEntry.date,
                          style: Theme.of(context).textTheme.subtitle2!),
                    ],
                  ),
                  trailing: Text(
                      historyEntry.imagePaths.length.toString() +
                          " " +
                          trailingDescription,
                      style: Theme.of(context).textTheme.subtitle1),
                ),
              ),
            );
          }
          index++;
        }

        return Scaffold(
          appBar: AppBar(),
          body: MenuPageContainer(
            "Bilderhistorie",
            "Verlauf aufgenommener Bilder",
            Column(
              children: [
                ...entries,
              ],
            ),
          ),
        );
      },
    );
  }
}
