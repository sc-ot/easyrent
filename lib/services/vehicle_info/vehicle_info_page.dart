import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:easyrent/core/constants.dart';
import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/core/utils.dart';
import 'package:easyrent/models/vehicle.dart';
import 'package:easyrent/services/vehicle_info/vehicle_info_provider.dart';
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
          body: CustomScrollView(
            controller: vehicleInfoProvider.scrollController,
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 250.0,
                floating: true,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text("Fahrzeug Nr. ${vehicle.vehicleNumber}",
                      style: Theme.of(context).textTheme.headline6!.copyWith(color: Theme.of(context).accentColor)),
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
                          autoplay: vehicleInfoProvider.vehicleImages.length <= 1 ? false : true,
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
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
                                              .headline6!.copyWith(color: Colors.white),
                                        ),
                                      ),
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
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
                                              .headline6!.copyWith(color: Colors.white),
                                        ),
                                      ),
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16.0),
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
                              SizedBox(
                                height: 8,
                              ),
                              VehicleInfoCardEntry(
                                  "Vertrag",
                                  "Mietvertrag noch hinzuf??gen!",
                                  LineIcons.fileContract),
                              SizedBox(
                                height: 8,
                              ),
                              VehicleInfoCardEntry(
                                  "Standort",
                                  vehicle.location.locationName,
                                  LineIcons.mapMarker),
                              SizedBox(
                                height: 8,
                              ),
                              VehicleInfoCardEntry("Notizen", vehicle.notes,
                                  LineIcons.stickyNote),
                            ],
                          ),
                          VehicleInfoCard(
                            "Fahrzeugtermine",
                            [
                              VehicleInfoCardEntry(
                                  "N??chster T??V",
                                  Utils.formatDateTimestring(
                                      vehicle.nextGeneralInspectionDate),
                                  LineIcons.calendar),
                              SizedBox(
                                height: 16,
                              ),
                              VehicleInfoCardEntry(
                                  "N??chster SP",
                                  Utils.formatDateTimestring(
                                      vehicle.nextSecurityInspectionDate),
                                  LineIcons.calendar),
                              SizedBox(
                                height: 16,
                              ),
                              VehicleInfoCardEntry(
                                  "N??chster UVV",
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
                              SizedBox(
                                height: 8,
                              ),
                              VehicleInfoCardEntry(
                                  "VIN", vehicle.vin, LineIcons.angleRight),
                              SizedBox(
                                height: 8,
                              ),
                              VehicleInfoCardEntry(
                                  "Kategorie",
                                  vehicle.vehicleCategory.vehicleCategoryName,
                                  LineIcons.angleRight),
                              SizedBox(
                                height: 8,
                              ),
                              VehicleInfoCardEntry(
                                  "Baujahr",
                                  vehicle.constructionYear.toString(),
                                  LineIcons.angleRight),
                              SizedBox(
                                height: 8,
                              ),
                              VehicleInfoCardEntry(
                                  "Erstzulassung",
                                  Utils.formatDateTimestring(
                                      vehicle.firstRegistrationDate),
                                  LineIcons.angleRight),
                              SizedBox(
                                height: 8,
                              ),
                              VehicleInfoCardEntry("Briefnummer",
                                  vehicle.letterNumber, LineIcons.angleRight),
                              SizedBox(
                                height: 8,
                              ),
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
                              SizedBox(
                                height: 8,
                              ),
                              VehicleInfoCardEntry(
                                  "Antrieb",
                                  vehicle.engineType.engineTypeName,
                                  LineIcons.angleRight),
                              SizedBox(
                                height: 8,
                              ),
                              VehicleInfoCardEntry(
                                  "Achsen",
                                  vehicle.countAxis.toString(),
                                  LineIcons.angleRight),
                              SizedBox(
                                height: 8,
                              ),
                              VehicleInfoCardEntry(
                                  "H??he/Breite/L??nge (cm)",
                                  vehicle.totalHeight.toString() +
                                      "/" +
                                      vehicle.totalWidth.toString() +
                                      "/" +
                                      vehicle.totalLength.toString(),
                                  LineIcons.angleRight),
                              SizedBox(
                                height: 8,
                              ),
                              VehicleInfoCardEntry(
                                  "Leergewicht",
                                  vehicle.emptyWeight.toStringAsFixed(0) +
                                      " kg",
                                  LineIcons.angleRight),
                              SizedBox(
                                height: 8,
                              ),
                              VehicleInfoCardEntry(
                                  "Maximalgewicht",
                                  vehicle.allowedTotalWeight
                                          .toStringAsFixed(0) +
                                      " kg",
                                  LineIcons.angleRight),
                              SizedBox(
                                height: 8,
                              ),
                              VehicleInfoCardEntry(
                                  "Zul??ssige Ladung",
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
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: cardData,
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
