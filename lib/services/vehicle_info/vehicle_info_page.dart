import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/services/vehicle_info/vehicle_info_provider.dart';
import 'package:easyrent/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class VehicleInfoPage extends StatelessWidget {
  const VehicleInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vehicleId = ModalRoute.of(context)!.settings.arguments as int;

    return ChangeNotifierProvider(
      create: (BuildContext context) => VehicleInfoProvider(vehicleId),
      builder: (context, child) {
        VehicleInfoProvider vehicleInfoProvider =
            Provider.of<VehicleInfoProvider>(context, listen: true);

        return Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 250.0,
                floating: true,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text("Fahrzeug Nr. 3187",
                      style: Theme.of(context).textTheme.headline6),
                  background: vehicleInfoProvider.ui == STATE.LOADING ||
                          vehicleInfoProvider.ui == STATE.IDLE
                      ? Center(child: ERLoadingIndicator())
                      : Swiper(
                          itemCount: vehicleInfoProvider.vehicleImages.length,
                          itemBuilder: (BuildContext context, int index) =>
                              FullScreenWidget(
                            disposeLevel: DisposeLevel.Low,
                            child: Hero(
                              tag: "fullScreenImage" + index.toString(),
                              child: CachedNetworkImage(
                                fadeInDuration: Duration(milliseconds: 300),
                                imageUrl: vehicleInfoProvider
                                    .vehicleImages[index].imageUrl!,
                                fit: BoxFit.cover,
                                errorWidget: (context, string, dynamic) {
                                  return Center(
                                      child: Text(
                                    "Das Bild konnte nicht geladen werden",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ));
                                },
                                httpHeaders: {
                                  "Authorization": vehicleInfoProvider
                                      .easyRentRepository
                                      .api
                                      .headers["Authorization"]!,
                                },
                              ),
                            ),
                          ),
                        ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Allgemein",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          Container(
                            child: Card(
                              elevation: 7,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Icon(Icons.info),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              LineIcon(LineIcons.info),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Text("nicht vefügbar"),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              LineIcon(LineIcons.fileContract),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Text("MV-3484"),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              LineIcon(LineIcons.mapMarker),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Text("Übach-Palenberg"),
                                            ],
                                          ),
                                        ],
                                      ),
                                      flex: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Fahrzeugtermine",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          Container(
                            child: Card(
                              elevation: 7,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Icon(Icons.info),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Nächster TÜV",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1,
                                          ),
                                          Text(
                                            "01.09.2023",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          ListTile(
                                            title: Text(
                                              "Nächste SP",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1,
                                            ),
                                            subtitle: Text(
                                              "01.09.2023",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                          ),
                                          ListTile(
                                            title: Text(
                                              "Nächste UVV",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1,
                                            ),
                                            subtitle: Text(
                                              "01.09.2023",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      flex: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
