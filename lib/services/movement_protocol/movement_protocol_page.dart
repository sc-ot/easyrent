import 'package:easyrent/core/constants.dart';
import 'package:easyrent/models/action_data.dart';
import 'package:easyrent/models/answer.dart';
import 'package:easyrent/models/inspection_report.dart';
import 'package:easyrent/models/question.dart';
import 'package:easyrent/services/movement_protocol_tire_profile/movement_protocol_tire_profile_page.dart';
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
      create: (contextProvider) =>
          MovementProtocolProvider(inspectionReport, context),
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
            actions: [
              TextButton(
                onPressed: () async {
                  int? result = await Navigator.pushNamed(context,
                          Constants.ROUTE_MOVEMENT_PROTOCOL_QUESTION_OVERVIEW,
                          arguments: movementProtocolProvider.inspectionReport)
                      as int?;
                  if (result != null) {
                    movementProtocolProvider.goToPage(result);
                  }
                },
                child: Text(
                  "Fragenübersicht",
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ],
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
                  PageView(
                    onPageChanged: (index) {
                      movementProtocolProvider.onPageChange();
                    },
                    controller: movementProtocolProvider.pageController,
                    children: <Widget>[MovementProtocolTireProfilePage()] +
                        movementProtocolProvider.questions
                            .map((e) => QuestionView(e))
                            .toList(),
                  ),

                  // TOP  QUESTION COUNT
                  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: double.infinity,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            (movementProtocolProvider.currentPageIndex + 1)
                                    .toString() +
                                " von " +
                                movementProtocolProvider.questionCount
                                    .toString(),
                          ),
                          SizedBox(
                            height: 8,
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

                  // IMAGE BUTTON
                  movementProtocolProvider.currentQuestion.imageAction != null
                      ? Positioned(
                          bottom: 96,
                          left: 0,
                          right: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 48,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: movementProtocolProvider
                                          .currentQuestion
                                          .actionsCompleted()
                                      ? Colors.green
                                      : Colors.red),
                              onPressed: movementProtocolProvider
                                      .currentQuestion.answerSelected
                                  ? () {
                                      movementProtocolProvider.takePictures();
                                    }
                                  : null,
                              child: Text(
                                "${movementProtocolProvider.missingImages()} / ${movementProtocolProvider.imagesToTake()} Fotos",
                                style: Theme.of(context).textTheme.button,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        )
                      : Container(),

                  Positioned(
                    bottom: 32,
                    left: 0,
                    right: 0,
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 300),
                      opacity: movementProtocolProvider
                                  .currentQuestion.answerSelected &&
                              movementProtocolProvider.currentQuestion
                                  .actionsCompleted()
                          ? 1
                          : 0.5,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: movementProtocolProvider.isLastPage()
                                  ? Colors.green
                                  : Colors.orange),
                          onPressed: movementProtocolProvider
                                      .currentQuestion.answerSelected &&
                                  movementProtocolProvider.currentQuestion
                                      .actionsCompleted()
                              ? () {
                                  if (movementProtocolProvider.isLastPage()) {
                                    movementProtocolProvider
                                        .goToPdfPreviewPage();
                                  } else {
                                    movementProtocolProvider.goToNextQuestion();
                                  }
                                }
                              : null,
                          child: Text(
                            movementProtocolProvider.isLastPage()
                                ? "Abschließen"
                                : "Weiter",
                            style: Theme.of(context).textTheme.button,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class QuestionView extends StatefulWidget {
  Question question;
  QuestionView(this.question, {Key? key}) : super(key: key);

  @override
  _QuestionViewState createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView>
    with AutomaticKeepAliveClientMixin<QuestionView> {
  @override
  Widget build(BuildContext context) {
    MovementProtocolProvider movementProtocolProvider =
        Provider.of<MovementProtocolProvider>(context, listen: true);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          // QUESTION
          AnimatedPositioned(
            top: widget.question.questionPosition,
            right: 0,
            left: 0,
            child: Text(
              widget.question.questionTemplate?.questionText ?? "",
              textAlign: TextAlign.center,
              maxLines: 2,
              style: Theme.of(context).textTheme.headline5,
              overflow: TextOverflow.ellipsis,
            ),
            duration: Duration(
              milliseconds: 300,
            ),
            curve: Curves.easeIn,
          ),
          // ANSWERS AND CHECKLIST
          AnimatedPositioned(
            top: widget.question.answersPosition,
            right: 0,
            left: 0,
            child: Column(
              children: [
                MovementProtocolQuestionAnswerButtons(
                  widget.question.questionTemplate?.answers ?? [],
                ),
                SizedBox(
                  height: movementProtocolProvider
                              .currentQuestion.checklistAction ==
                          null
                      ? 0
                      : 16,
                ),
                widget.question.checklistAction == null
                    ? Container()
                    : MovementProtocolQuestionChecklist(
                        widget.question,
                      ),
              ],
            ),
            duration: Duration(
              milliseconds: 300,
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class MovementProtocolQuestionAnswerButtons extends StatelessWidget {
  List<Answer> answers;
  MovementProtocolQuestionAnswerButtons(this.answers, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MovementProtocolProvider movementProtocolProvider =
        Provider.of<MovementProtocolProvider>(context, listen: false);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: answers.length,
      itemBuilder: (context, index) {
        return Container(
          width: MediaQuery.of(context).size.width,
          child: Card(
            elevation: 7,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: InkWell(
              onTap: () {
                movementProtocolProvider.selectAnswer(answers[index]);
              },
              borderRadius: BorderRadius.circular(15),
              child: ListTile(
                title: Text(answers[index].answerText),
                trailing: Icon(
                  answers[index].answerValue == 1
                      ? movementProtocolProvider.currentQuestion
                              .isAnswerSelected(answers[index])
                          ? Icons.thumb_up
                          : Icons.thumb_up_outlined
                      : movementProtocolProvider.currentQuestion
                              .isAnswerSelected(answers[index])
                          ? Icons.thumb_down
                          : Icons.thumb_down_outlined,
                  color: answers[index].answerValue == 1
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class MovementProtocolQuestionChecklist extends StatelessWidget {
  Question question;
  MovementProtocolQuestionChecklist(this.question, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MovementProtocolProvider movementProtocolProvider =
        Provider.of<MovementProtocolProvider>(context, listen: false);
    return Container(
      child: ListView.builder(
        itemCount: question.checklistAction!.actionData.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(question.checklistAction!.actionData[index].dataName),
            value: question.isCheckListEntrySelected(
                question.checklistAction!.actionData[index]),
            onChanged: (val) {
              movementProtocolProvider.selectChecklist(
                  question.checklistAction!.actionData[index], val!);
            },
          );
        },
      ),
    );
  }
}
