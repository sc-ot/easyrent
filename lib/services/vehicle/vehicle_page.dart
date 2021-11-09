import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/models/vehicle.dart';
import 'package:easyrent/widgets/loading_indicator.dart';
import 'package:easyrent/widgets/vehicle_search_list_entry.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

import '../../../widgets/menu_page_container_widget.dart';
import 'vehicle_provider.dart';

class VehiclePage extends StatefulWidget {
  final String text;
  final String subTitle;
  const VehiclePage(this.text, this.subTitle, {Key? key});

  @override
  _VehiclePageState createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclePage>
    with AutomaticKeepAliveClientMixin<VehiclePage> {
  @override
  Widget build(BuildContext context) {
    VehicleProvider vehicleProvider = Provider.of(context, listen: true);
    return MenuPageContainer(
      widget.text,
      widget.subTitle,
      Expanded(
        child: Column(
          children: [
            TextField(
              controller: vehicleProvider.vehicleSearchFieldController,
              onChanged: (text) {
                vehicleProvider.fetchVehicle(0, isSearch: true);
              },
              decoration: InputDecoration(
                hintText: "Suchen",
              ),
            ),
            vehicleProvider.ui == STATE.LOADING
                ? ERLoadingIndicator()
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: RefreshIndicator(
                        color: Theme.of(context).primaryColorLight,
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        onRefresh: () => Future.sync(
                            () => vehicleProvider.pagingController.refresh()),
                        child: PagedListView<int, Vehicle>(
                          scrollController: vehicleProvider.scrollController,
                          shrinkWrap: true,
                          pagingController: vehicleProvider.pagingController,
                          builderDelegate: PagedChildBuilderDelegate<Vehicle>(
                              itemBuilder: (context, item, index) =>
                                  VehicleSearchListEntry(
                                    item,
                                  ),
                              firstPageErrorIndicatorBuilder: (context) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 16.0, bottom: 12),
                                      child: Text(
                                        "Es konnten keine Fahrzeuge geladen werden",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Text(
                                      "Übeprüfen Sie Ihre Internetverbindung und versuchen Sie es erneut.",
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                );
                              },
                              newPageErrorIndicatorBuilder: (context) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 16.0, bottom: 12),
                                      child: Text(
                                        "Es konnten keine Fahrzeuge geladen werden",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Text(
                                      "Übeprüfen Sie Ihre Internetverbindung und versuchen Sie es erneut.",
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                );
                              },
                              noItemsFoundIndicatorBuilder: (context) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 16.0, bottom: 12),
                                      child: Text(
                                        "Es wurden keine passenden Fahrzeuge für „${vehicleProvider.vehicleSearchFieldController.text}“ gefunden",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Text(
                                      "Übeprüfen Sie Ihre Eingabe und die bestehende Internetverbindung",
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                );
                              },
                              firstPageProgressIndicatorBuilder: (context) {
                                return Container(
                                  height: MediaQuery.of(context).size.height -
                                      MediaQuery.of(context).size.height * 0.1 -
                                      MediaQuery.of(context).size.height * 0.25,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          child: LoadingIndicator(
                                            indicatorType:
                                                Indicator.circleStrokeSpin,
                                            colors: [
                                              Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            "Fahrzeuge werden geladen",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              newPageProgressIndicatorBuilder: (context) {
                                return Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      child: LoadingIndicator(
                                        indicatorType:
                                            Indicator.circleStrokeSpin,
                                        colors: [
                                          Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
