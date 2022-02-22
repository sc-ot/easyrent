import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:easyrent/core/constants.dart';
import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/models/inspection_report.dart';
import 'package:easyrent/widgets/pdf_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../widgets/menu_page_container_widget.dart';
import 'movement_protocol_pdf_preview_provider.dart';

class MovementProtocolPdfPreviewPage extends StatelessWidget {
  MovementProtocolPdfPreviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic argument =
        ModalRoute.of(context)!.settings.arguments as InspectionReport;

    return ChangeNotifierProvider<MovementProtocolPdfPreviewProvider>(
      create: (context) => MovementProtocolPdfPreviewProvider(argument),
      builder: (context, child) {
        MovementProtocolPdfPreviewProvider movementProtocolPdfPreviewProvider =
            Provider.of<MovementProtocolPdfPreviewProvider>(context,
                listen: true);
        return MenuPageContainer(
          "Vorschau",
          "Zeigen Sie sich das Übergabeprotokoll an",
          Expanded(
            child: Stack(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: movementProtocolPdfPreviewProvider.ui ==
                              STATE.ERROR
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Das Übergabeprotokoll kann nicht angezeigt werden (Fehler: ${movementProtocolPdfPreviewProvider.failure?.errorMessage} (Statuscode  ${movementProtocolPdfPreviewProvider.failure?.statusCode})",
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      movementProtocolPdfPreviewProvider
                                          .getPdfDocument();
                                    },
                                    child: Text("Erneut versuchen",
                                        style:
                                            Theme.of(context).textTheme.button),
                                  )
                                ],
                              ),
                            )
                          : Center(
                              child: movementProtocolPdfPreviewProvider.ui ==
                                      STATE.LOADING
                                  ? PDFLoadingIndicator(
                                      "Übergabeprotokoll wird generiert ...")
                                  : PDFViewer(
                                      progressIndicator: PDFLoadingIndicator(
                                          "Seite wird vorbereitet ..."),
                                      showPicker: false,
                                      showNavigation: false,
                                      showIndicator: true,
                                      document:
                                          movementProtocolPdfPreviewProvider
                                              .pdfDocument!,
                                    ),
                            ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 32,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () async {
                        SystemChrome.setPreferredOrientations([
                          DeviceOrientation.landscapeLeft,
                        ]);
                        InspectionReport report = await Navigator.pushNamed(
                            context,
                            Constants.ROUTE_MOVEMENT_PROTOCOL_SIGNATURE,
                            arguments: movementProtocolPdfPreviewProvider
                                .inspectionReport) as InspectionReport;
                        movementProtocolPdfPreviewProvider.inspectionReport =
                            report;
                        movementProtocolPdfPreviewProvider.getPdfDocument();
                      },
                      child: Text(
                        "Unterschreiben",
                        style: Theme.of(context).textTheme.button,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 400),
                  opacity:
                      movementProtocolPdfPreviewProvider.ui == STATE.SUCCESS
                          ? 1
                          : 0.5,
                  child: TextButton(
                    onPressed: movementProtocolPdfPreviewProvider.ui ==
                            STATE.SUCCESS
                        ? () {
                            Navigator.pushNamed(
                                context,
                                Constants
                                    .ROUTE_MOVEMENT_PROTOCOL_PDF_PREVIEW_FULLSCREEN,
                                arguments: movementProtocolPdfPreviewProvider
                                    .pdfDocument);
                          }
                        : null,
                    child: Text(
                      "Im Vollbild anzeigen",
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
