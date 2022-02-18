import 'dart:typed_data';

import 'package:easyrent/core/state_provider.dart';

import 'package:easyrent/models/inspection_report.dart';
import 'package:flutter/services.dart';
import 'package:sc_appframework/utils/base64_utils.dart';
import 'package:signature/signature.dart';

class MovementProtocolSignatureProvider extends StateProvider {
  late InspectionReport inspectionReport;
  SignatureController signatureController = SignatureController();
  bool isEmpty = true;

  MovementProtocolSignatureProvider(this.inspectionReport) {
    setState(state: STATE.ERROR);

    signatureController.addListener(
      () {
        if (isEmpty) {
          setState(state: STATE.IDLE);
          isEmpty = false;
        }
      },
    );
  }

  void clearSignature() {
    signatureController.clear();
    isEmpty = true;
    setState(state: STATE.ERROR);
  }

  void saveSignature() async {
    Uint8List? bytes = await signatureController.toPngBytes();
    if (bytes != null) {
      inspectionReport.signature =
          "data:image/jpg;base64," + Base64Utils.base64StringFromData(bytes);
    }
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }
}
