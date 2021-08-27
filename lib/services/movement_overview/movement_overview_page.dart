import 'package:easyrent/core/authenticator.dart';
import 'package:easyrent/models/planned_movement.dart';
import 'package:easyrent/models/vehicle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/menu_page_container_widget.dart';
import 'movement_overview_providert.dart';

class MovementOverviewPage extends StatelessWidget {
  const MovementOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MovementOverviewProvider movementOverviewProvider;
    dynamic argument = ModalRoute.of(context)!.settings.arguments;
    if (argument is Vehicle) {
      argument = ModalRoute.of(context)!.settings.arguments as Vehicle;
      movementOverviewProvider = MovementOverviewProvider(vehicle: argument);
    } else {
      argument = ModalRoute.of(context)!.settings.arguments as PlannedMovement;
      movementOverviewProvider = MovementOverviewProvider(plannedMovement: argument);
    }

    return ChangeNotifierProvider<MovementOverviewProvider>(
      create: (context) => movementOverviewProvider,
      builder: (context, child) {
        MovementOverviewProvider movementOverviewProvider =
            Provider.of<MovementOverviewProvider>(context, listen: true);
        return Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Authenticator.logout(context);
            },
            backgroundColor: Colors.red,
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            label: Text(
              "Abmelden",
              style: Theme.of(context)
                  .textTheme
                  .button!
                  .copyWith(color: Colors.white),
            ),
          ),
          body: Container(),
        );
      },
    );
  }
}
