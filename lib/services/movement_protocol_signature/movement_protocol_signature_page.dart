import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/models/inspection_report.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';

import 'movement_protocol_signature_provider.dart';

class MovementProtocolSignaturePage extends StatefulWidget {
  MovementProtocolSignaturePage({Key? key}) : super(key: key);

  @override
  State<MovementProtocolSignaturePage> createState() =>
      _MovementProtocolSignaturePageState();
}

class _MovementProtocolSignaturePageState
    extends State<MovementProtocolSignaturePage> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dynamic argument =
        ModalRoute.of(context)!.settings.arguments as InspectionReport;

    return ChangeNotifierProvider<MovementProtocolSignatureProvider>(
      create: (context) => MovementProtocolSignatureProvider(argument),
      builder: (context, child) {
        MovementProtocolSignatureProvider
            movementProtocolSignaturePageProvider =
            Provider.of<MovementProtocolSignatureProvider>(context,
                listen: true);

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              "Unterschreiben",
            ),
          ),
          body: Stack(
            children: [
              Signature(
                backgroundColor: Colors.white,
                height: MediaQuery.of(context).size.height,
                controller:
                    movementProtocolSignaturePageProvider.signatureController,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      "Bitte unterschreiben Sie mit dem Finger auf die weiße Fläche",
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      width: 32,
                    ),
                    Lottie.asset(
                      "assets/signature_finger.json",
                      width: MediaQuery.of(context).size.height * 0.25,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.delete,
                      size: 30,
                    ),
                    onPressed: () {
                      movementProtocolSignaturePageProvider.clearSignature();
                    },
                    color: Colors.red,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: AnimatedOpacity(
                    opacity:
                        movementProtocolSignaturePageProvider.ui == STATE.ERROR
                            ? 0.5
                            : 1,
                    duration: Duration(milliseconds: 300),
                    child: FloatingActionButton.large(
                      backgroundColor: Colors.green,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                      onPressed: movementProtocolSignaturePageProvider.ui ==
                              STATE.ERROR
                          ? null
                          : () {
                              movementProtocolSignaturePageProvider
                                  .saveSignature();
                              Navigator.pop(
                                  context,
                                  movementProtocolSignaturePageProvider
                                      .inspectionReport);
                            },
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
