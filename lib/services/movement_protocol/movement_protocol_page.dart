import 'package:easyrent/models/answer.dart';
import 'package:easyrent/models/inspection_report.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'movement_protocol_provider.dart';

class MovementProtocolPage extends StatelessWidget {
  const MovementProtocolPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    InspectionReport inspectionReport = args as InspectionReport;
    return ChangeNotifierProvider<MovementProtocolProvider>(
      create: (context) => MovementProtocolProvider(inspectionReport),
      builder: (context, child) {
        MovementProtocolProvider movementProtocolProvider =
            Provider.of<MovementProtocolProvider>(context, listen: true);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              movementProtocolProvider.inspectionReport.vehicle!.licensePlate,
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ),
          resizeToAvoidBottomInset: false,

          // see https://stackoverflow.com/questions/61058420/flutter-pagecontroller-page-cannot-be-accessed-before-a-pageview-is-built-with
          body: FutureBuilder(
              future: movementProtocolProvider.initializeController(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SizedBox();
                }
                return Stack(
                  children: [
                    PageView.builder(
                      itemCount: movementProtocolProvider.questionCount,
                      controller: movementProtocolProvider.pageController,
                      onPageChanged: (index) {
                        movementProtocolProvider.updatePage(index);
                      },
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                movementProtocolProvider.currentQuestion
                                        .questionTemplate?.questionText ??
                                    "",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            MovementProtocolQuestionAnswerButtons(
                                movementProtocolProvider.currentQuestion
                                        .questionTemplate?.answers ??
                                    []),
                          ],
                        );
                      },
                    ),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.width * 0.1,
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              (movementProtocolProvider.currentPageIndex + 1)
                                      .toString() +
                                  " von " +
                                  movementProtocolProvider.questionCount
                                      .toString(),
                            ),
                            Text(
                              (movementProtocolProvider.currentCategory
                                      .categoryTemplate?.categoryName ??
                                  ""),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
        );
      },
    );
  }
}

class MovementProtocolQuestionAnswerButtons extends StatelessWidget {
  List<Answer> answers;
  MovementProtocolQuestionAnswerButtons(this.answers, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var answer in answers)
          Container(
            width: MediaQuery.of(context).size.width / (answers.length + 1),
            height: MediaQuery.of(context).size.height * 0.15,
            child: Card(
              elevation: 7,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      answer.answerValue == 1
                          ? Icons.thumb_up_outlined
                          : Icons.thumb_down_outlined,
                      color:
                          answer.answerValue == 1 ? Colors.green : Colors.red,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(answer.answerText),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
