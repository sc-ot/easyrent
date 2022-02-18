import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:easyrent/widgets/pdf_loading_indicator.dart';
import 'package:flutter/material.dart';

class MovementProtocolPdfPreviewFullScreenPage extends StatelessWidget {
  MovementProtocolPdfPreviewFullScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PDFDocument pdfDocument =
        ModalRoute.of(context)!.settings.arguments as PDFDocument;
    return Scaffold(
      appBar: AppBar(),
      body: PDFViewer(
        document: pdfDocument,
        progressIndicator: PDFLoadingIndicator("Seite wird geladen"),
        showPicker: false,
        showNavigation: false,
      ),
    );
  }
}
