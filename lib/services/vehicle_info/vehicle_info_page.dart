import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/core/utils.dart';
import 'package:easyrent/models/vehicle.dart';
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
    final vehicle = ModalRoute.of(context)!.settings.arguments as Vehicle;

    return ChangeNotifierProvider(
      create: (BuildContext context) => VehicleInfoProvider(vehicle),
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
                  centerTitle: true,
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
                          autoplay: true,
                          autoplayDisableOnInteraction: true,
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
                          VehicleInfoCard(
                            "Allgemein",
                            [
                              VehicleInfoCardEntry(
                                  "Status", "Nicht verfügbar", LineIcons.info),
                              SizedBox(
                                height: 8,
                              ),
                              VehicleInfoCardEntry(
                                  "Vertrag", "MV-3245", LineIcons.fileContract),
                              SizedBox(
                                height: 8,
                              ),
                              VehicleInfoCardEntry("Standort",
                                  "Übach-Palenberg", LineIcons.mapMarker),
                              SizedBox(
                                height: 8,
                              ),
                              VehicleInfoCardEntry("Notizen", "Keine Notizen",
                                  LineIcons.stickyNote),
                            ],
                          ),
                          VehicleInfoCard(
                            "Fahrzeugtermine",
                            [
                              VehicleInfoCardEntry("Nächster TÜV", "31.04.2031",
                                  LineIcons.calendar),
                              SizedBox(
                                height: 16,
                              ),
                              VehicleInfoCardEntry("Nächster SP", "06.05.2021",
                                  LineIcons.calendar),
                              SizedBox(
                                height: 16,
                              ),
                              VehicleInfoCardEntry("Nächster UVV", "01.03.2021",
                                  LineIcons.calendar),
                            ],
                          ),
                          VehicleInfoCard(
                            "Fahrzeugdetails",
                            [
                              VehicleInfoCardEntry("Hersteller", "31.04.2031",
                                  LineIcons.angleRight),
                              SizedBox(
                                height: 8,
                              ),
                              VehicleInfoCardEntry(
                                  "VIN", "31.04.2031", LineIcons.angleRight),
                              SizedBox(
                                height: 8,
                              ),
                              VehicleInfoCardEntry("Kategorie", "31.04.2031",
                                  LineIcons.angleRight),
                              SizedBox(
                                height: 8,
                              ),
                              VehicleInfoCardEntry("Baujahr", "31.04.2031",
                                  LineIcons.angleRight),
                              SizedBox(
                                height: 8,
                              ),
                              VehicleInfoCardEntry("Erstzulassung",
                                  "31.04.2031", LineIcons.angleRight),
                              SizedBox(
                                height: 8,
                              ),
                              VehicleInfoCardEntry("Briefnummer", "31.04.2031",
                                  LineIcons.angleRight),
                              SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                          VehicleInfoCard(
                            "Technische Daten",
                            [
                              VehicleInfoCardEntry("Motorleistung",
                                  "31.04.2031", LineIcons.angleRight),
                              SizedBox(
                                height: 8,
                              ),
                              VehicleInfoCardEntry("Antrieb", "31.04.2031",
                                  LineIcons.angleRight),
                              SizedBox(
                                height: 8,
                              ),
                              VehicleInfoCardEntry(
                                  "Achsen", "31.04.2031", LineIcons.angleRight),
                              SizedBox(
                                height: 8,
                              ),
                              VehicleInfoCardEntry("Höhe/Breite/Länge",
                                  "31.04.2031", LineIcons.angleRight),
                              SizedBox(
                                height: 8,
                              ),
                              VehicleInfoCardEntry("Leergewicht", "31.04.2031",
                                  LineIcons.angleRight),
                              SizedBox(
                                height: 8,
                              ),
                              VehicleInfoCardEntry("Maximalgewicht",
                                  "31.04.2031", LineIcons.angleRight),
                              SizedBox(
                                height: 8,
                              ),
                              VehicleInfoCardEntry("Zulässige Ladung",
                                  "31.04.2031", LineIcons.angleRight),
                            ],
                          ),
                          VehicleInfoCard(
                            "Aufbauten",
                            [
                              VehicleInfoCardEntry(
                                  "Nummer", "A-1182", LineIcons.angleRight),
                              SizedBox(
                                height: 8,
                              ),
                              VehicleInfoCardEntry(
                                  "Typ", "-", LineIcons.angleRight),
                            ],
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

class VehicleInfoCardEntry extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  const VehicleInfoCardEntry(this.title, this.subTitle, this.icon, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .subtitle2!
              .copyWith(color: Theme.of(context).accentColor),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          subTitle,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}

class VehicleInfoCard extends StatelessWidget {
  List<Widget> cardData;
  String title;
  VehicleInfoCard(this.title, this.cardData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Card(
          elevation: 7,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      title,
                      style: Utils.getDevice(context) == Device.TABLET
                          ? Theme.of(context).textTheme.headline6
                          : Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: cardData,
                  ),
                  flex: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
