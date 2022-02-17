import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/core/utils.dart';
import 'package:easyrent/models/inspection_report.dart';
import 'package:easyrent/models/movement_overview.dart';
import 'package:easyrent/services/movement_protocol/movement_protocol_page.dart';
import 'package:easyrent/services/movement_protocol/movement_protocol_provider.dart';
import 'package:easyrent/widgets/loading_indicator.dart';
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
          "Übergabeprotokoll erstellen",
          "Zeigen Sie sich das Übergabeprotokoll an",
          Expanded(
            child: Stack(
              children: [
                Container(
                  child: movementProtocolPdfPreviewProvider.ui == STATE.ERROR
                      ? Container(
                          height: 20,
                          width: 20,
                          color: Colors.red,
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.75,
                            child: Center(
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
                      onPressed: null,
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
                    onPressed: () {},
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

class PDFLoadingIndicator extends StatelessWidget {
  String title;
  PDFLoadingIndicator(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: ERLoadingIndicator(),
            width: MediaQuery.of(context).size.height * 0.08,
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          Text(
            this.title,
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }
}
