import 'package:easyrent/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../widgets/menu_page_container_widget.dart';
import 'movement_miles_and_license_plate_provider.dart';

class MovementMilesAndLicensePlatePage extends StatelessWidget {
  const MovementMilesAndLicensePlatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MovementMilesAndLicensePlateProvider>(
      create: (context) => MovementMilesAndLicensePlateProvider(),
      builder: (context, child) {
        MovementMilesAndLicensePlateProvider
            movementMilesAndLicensePlateProvider =
            Provider.of<MovementMilesAndLicensePlateProvider>(context,
                listen: true);

        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(),
          body: MenuPageContainer(
            "Fotos",
            "Nehmen Sie Bilder für das Übergabeprotokoll auf",
            Column(
              children: [
                Expanded(
                  flex: 4,
                  child: PageView(
                    controller:
                        movementMilesAndLicensePlateProvider.pageController,
                    onPageChanged: (index) {
                      movementMilesAndLicensePlateProvider.pageChanged(index);
                    },
                    children: [
                      Container(
                          child: Center(
                            child: Text(
                              "Führerschein",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                        ),
                      Container(
                            child: Center(
                              child: Text(
                                "Führerschein Rückseite",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            iconSize: 50,
                            icon: Icon(
                              Icons.camera_alt_outlined,
                            ),
                            onPressed: () {
                              movementMilesAndLicensePlateProvider
                                  .takePicture(context);
                            },
                          ),
                          SizedBox(
                            width: 32,
                          ),
                          IconButton(
                            iconSize: 50,
                            icon: Icon(
                              Icons.delete_forever_outlined,
                            ),
                            onPressed: () {},
                          )
                        ],
                      ),
                      AnimatedSmoothIndicator(
                        activeIndex:
                            movementMilesAndLicensePlateProvider.currentPage,
                        count: 2,
                        effect: WormEffect(
                          activeDotColor: Theme.of(context).accentColor,
                          dotColor: Theme.of(context).primaryColorLight,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                        child: Text(
                          "Fortfahren",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context,
                              Constants.ROUTE_MOVEMENT_MILES_AND_LICENSE_PLATE);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            isMobile: true,
          ),
        );
      },
    );
  }
}
