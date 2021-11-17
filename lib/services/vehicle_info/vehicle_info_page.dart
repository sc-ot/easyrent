import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:easyrent/core/constants.dart';
import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/core/utils.dart';
import 'package:easyrent/models/vehicle.dart';
import 'package:easyrent/services/vehicle_info/vehicle_info_provider.dart';
import 'package:easyrent/widgets/custom_grid_view.dart';
import 'package:easyrent/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
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
          body: SafeArea(
            child: CustomScrollView(
              controller: vehicleInfoProvider.scrollController,
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 250.0,
                  floating: true,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    titlePadding: EdgeInsets.all(8),
                    title: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.withOpacity(0.4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                          child: Text("Fahrzeug Nr. ${vehicle.vehicleNumber}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(color: Colors.white)),
                        ),
                      ),
                    ),
                    background: vehicleInfoProvider.ui == STATE.LOADING ||
                            vehicleInfoProvider.ui == STATE.IDLE
                        ? Center(
                            child: ERLoadingIndicator(),
                          )
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
                            autoplay:
                                vehicleInfoProvider.vehicleImages.length <= 1
                                    ? false
                                    : true,
                            loop: true,
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
                              padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                              child: Center(
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context,
                                              Constants
                                                  .ROUTE_VEHICLE_INFO_MOVEMENTS,
                                              arguments: vehicle);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 12, 0, 12),
                                          child: Text(
                                            "Bewegungen",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6!
                                                .copyWith(color: Colors.white),
                                          ),
                                        ),
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context,
                                              Constants
                                                  .ROUTE_VEHICLE_INFO_EQUIPMENTS,
                                              arguments: vehicle);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 12, 0, 12),
                                          child: Text(
                                            "Ausstattungen",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6!
                                                .copyWith(color: Colors.white),
                                          ),
                                        ),
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context,
                                              Constants
                                                  .ROUTE_VEHICLE_INFO_LOCATION,
                                              arguments: vehicle);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 12, 0, 12),
                                          child: Text(
                                            "Standort",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6!
                                                .copyWith(color: Colors.white),
                                          ),
                                        ),
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            VehicleInfoCard(
                              "Allgemein",
                              [
                                VehicleInfoCardEntry(
                                    "Status",
                                    vehicle.status.statusDef.statusName,
                                    LineIcons.info),
                                VehicleInfoCardEntry(
                                    "Vertrag",
                                    "Mietvertrag noch hinzufügen!",
                                    LineIcons.fileContract),
                                VehicleInfoCardEntry(
                                    "Standort",
                                    vehicle.location.locationName,
                                    LineIcons.mapMarker),
                                VehicleInfoCardEntry("Notizen", vehicle.notes,
                                    LineIcons.stickyNote),
                              ],
                            ),
                            VehicleInfoCard(
                              "Fahrzeugtermine",
                              [
                                VehicleInfoCardEntry(
                                    "Nächster TÜV",
                                    Utils.formatDateTimestring(
                                        vehicle.nextGeneralInspectionDate),
                                    LineIcons.calendar),
                                VehicleInfoCardEntry(
                                    "Nächster SP",
                                    Utils.formatDateTimestring(
                                        vehicle.nextSecurityInspectionDate),
                                    LineIcons.calendar),
                                VehicleInfoCardEntry(
                                    "Nächster UVV",
                                    Utils.formatDateTimestring(
                                        vehicle.nextUvvInspectionDate),
                                    LineIcons.calendar),
                              ],
                            ),
                            VehicleInfoCard(
                              "Fahrzeugdetails",
                              [
                                VehicleInfoCardEntry(
                                    "Hersteller",
                                    vehicle.manufacturer.manufacturerName,
                                    LineIcons.angleRight),
                                VehicleInfoCardEntry(
                                    "VIN", vehicle.vin, LineIcons.angleRight),
                                VehicleInfoCardEntry(
                                    "Kategorie",
                                    vehicle.vehicleCategory.vehicleCategoryName,
                                    LineIcons.angleRight),
                                VehicleInfoCardEntry(
                                    "Baujahr",
                                    vehicle.constructionYear.toString(),
                                    LineIcons.angleRight),
                                VehicleInfoCardEntry(
                                    "Erstzulassung",
                                    Utils.formatDateTimestring(
                                        vehicle.firstRegistrationDate),
                                    LineIcons.angleRight),
                                VehicleInfoCardEntry("Briefnummer",
                                    vehicle.letterNumber, LineIcons.angleRight),
                              ],
                            ),
                            VehicleInfoCard(
                              "Technische Daten",
                              [
                                VehicleInfoCardEntry(
                                    "Motorleistung",
                                    vehicle.kilowatt.toString() +
                                        " kW (${vehicle.horsePower} PS)",
                                    LineIcons.angleRight),
                                VehicleInfoCardEntry(
                                    "Antrieb",
                                    vehicle.engineType.engineTypeName,
                                    LineIcons.angleRight),
                                VehicleInfoCardEntry(
                                    "Achsen",
                                    vehicle.countAxis.toString(),
                                    LineIcons.angleRight),
                                VehicleInfoCardEntry(
                                    "Höhe/Breite/Länge (cm)",
                                    vehicle.totalHeight.toString() +
                                        "/" +
                                        vehicle.totalWidth.toString() +
                                        "/" +
                                        vehicle.totalLength.toString(),
                                    LineIcons.angleRight),
                                VehicleInfoCardEntry(
                                    "Leergewicht",
                                    vehicle.emptyWeight.toStringAsFixed(0) +
                                        " kg",
                                    LineIcons.angleRight),
                                VehicleInfoCardEntry(
                                    "Maximalgewicht",
                                    vehicle.allowedTotalWeight
                                            .toStringAsFixed(0) +
                                        " kg",
                                    LineIcons.angleRight),
                                VehicleInfoCardEntry(
                                    "Zulässige Ladung",
                                    vehicle.payloadWeight.toStringAsFixed(0) +
                                        " kg",
                                    LineIcons.angleRight),
                              ],
                            ),
                            VehicleInfoCard(
                              "Aufbauten",
                              [
                                VehicleInfoCardEntry(
                                    "Nummer", "A-1182", LineIcons.angleRight),
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
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .subtitle2!
              .copyWith(color: Theme.of(context).colorScheme.secondary),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          subTitle.isEmpty || subTitle == "0" ? "-" : subTitle,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 7,
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomGridView(
                    builder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: cardData[index],
                      );
                    },
                    mainAxisCount:
                        Utils.getDevice(context) == Device.PHONE ? 1 : 2,
                    list: cardData,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
