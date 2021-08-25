import 'package:easyrent/core/authenticator.dart';
import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/services/client/client_provider.dart';
import 'package:easyrent/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClientPage extends StatelessWidget {
  const ClientPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => ClientProvider(),
        builder: (context, child) {
          ClientProvider clientProvider =
              Provider.of<ClientProvider>(context, listen: true);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      "Willkommen, " + Authenticator.getUsername(),
                      style: Theme.of(context).textTheme.headline4,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    "Bitte wählen Sie einen Mandanten aus",
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: clientProvider.ui == STATE.SUCCESS
                      ? Container(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: clientProvider.clients.length,
                            itemBuilder: (context, index) {
                              return Container(
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3.0),
                                  ),
                                  color: Theme.of(context).primaryColorLight,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(3.0),
                                    onTap: () {
                                      clientProvider.selectClient(
                                          context, index);
                                    },
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(24.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 30,
                                              width: 1,
                                              color: Colors.orange,
                                            ),
                                            SizedBox(
                                              width: 16,
                                            ),
                                            Text(
                                                clientProvider
                                                    .clients[index].name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5!),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Center(
                          child: ERLoadingIndicator(),
                        ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
