import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:easyrent/core/state_provider.dart';

import 'package:easyrent/models/inspection_report.dart';
import 'package:easyrent/network/repository.dart';
import 'package:sc_appframework/storage/sc_internal_storage.dart';
import 'package:sc_appframework/utils/file_utils.dart';

class MovementProtocolPdfPreviewProvider extends StateProvider {
  late InspectionReport inspectionReport;
  PDFDocument? pdfDocument;

  MovementProtocolPdfPreviewProvider(this.inspectionReport) {
    getPdfDocument();
  }

  void getPdfDocument() async {
    setState(state: STATE.LOADING);

    var result = await EasyRentRepository().getPdfDocument(inspectionReport);
    result.fold(
      (failure) {
        setState(state: STATE.ERROR);
      },
      (success) async {
        File pdfFile = await SCInternalStorage.saveBytesAsFile(
            "", "inspection_report.pdf", success.bodyBytes);

        pdfDocument = await PDFDocument.fromFile(
          pdfFile,
        );

        setState(state: STATE.SUCCESS);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
