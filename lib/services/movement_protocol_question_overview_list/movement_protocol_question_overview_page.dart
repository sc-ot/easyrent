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
import 'movement_protocol_question_overview_provider.dart';

class MovementProtocolQuestionOverviewPage extends StatelessWidget {
  MovementProtocolQuestionOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic argument =
        ModalRoute.of(context)!.settings.arguments as InspectionReport;

    return ChangeNotifierProvider<MovementProtocolQuestionOverviewProvider>(
      create: (context) => MovementProtocolQuestionOverviewProvider(argument),
      builder: (context, child) {
        MovementProtocolQuestionOverviewProvider
            movementProtocolQuestionOverviewProvider =
            Provider.of<MovementProtocolQuestionOverviewProvider>(context,
                listen: true);

        return MenuPageContainer(
          "Fragen",
          "Übersicht aller Fragen",
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount:
                    movementProtocolQuestionOverviewProvider.questions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      if (movementProtocolQuestionOverviewProvider
                              .questions[index].answer!.id !=
                          0) {
                        Navigator.pop(context, index);
                      }
                    },
                    leading: Text((index + 1).toString()),
                    contentPadding: EdgeInsets.all(0),
                    title: Text(movementProtocolQuestionOverviewProvider
                            .questions[index].questionTemplate?.questionText ??
                        ""),
                    subtitle: Text(movementProtocolQuestionOverviewProvider
                            .questions[index].answer?.answerText ??
                        ""),
                    trailing: movementProtocolQuestionOverviewProvider
                                .questions[index].answer!.id !=
                            0
                        ? Icon(
                            movementProtocolQuestionOverviewProvider
                                        .questions[index].answer!.answerValue ==
                                    1
                                ? Icons.thumb_up
                                : Icons.thumb_down,
                            color: movementProtocolQuestionOverviewProvider
                                        .questions[index].answer!.answerValue ==
                                    1
                                ? Colors.green
                                : Colors.red,
                          )
                        : SizedBox(
                            height: 0,
                            width: 0,
                          ),
                  );
                }),
          ),
          appBar: AppBar(
            title: Text(""),
          ),
        );
      },
    );
  }
}
