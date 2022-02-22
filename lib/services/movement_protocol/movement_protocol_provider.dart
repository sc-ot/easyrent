import 'dart:async';

import 'package:easyrent/core/constants.dart';
import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/models/action_data.dart';
import 'package:easyrent/models/answer.dart';
import 'package:easyrent/models/camera.dart';
import 'package:easyrent/models/camera_picture.dart';
import 'package:easyrent/models/category.dart';
import 'package:easyrent/models/category_question_action_data.dart';
import 'package:easyrent/models/inspection_report.dart';
import 'package:easyrent/models/question.dart';
import 'package:easyrent/models/action.dart' as ir;
import 'package:easyrent/services/camera/camera_page.dart';
import 'package:flutter/cupertino.dart';

class MovementProtocolProvider extends StateProvider {
  late InspectionReport inspectionReport;
  late BuildContext context;

  MovementProtocolProvider(this.inspectionReport, BuildContext context) {
    this.context = context;

    for (var category in inspectionReport.categories) {
      for (var question in category.questions) {
        question.questionPosition = MediaQuery.of(context).size.height * 0.3;
        question.answersPosition = MediaQuery.of(context).size.height * 0.6;
      }
    }
  }

  Future<bool> initializeController() {
    Completer<bool> completer = new Completer<bool>();

    /// Callback called after widget has been fully built
    WidgetsBinding.instance!.addPostFrameCallback(
      (timeStamp) {
        completer.complete(true);
      },
    );
    return completer.future;
  }

  void onPageChange() {
    setState(state: STATE.SUCCESS);
  }

  // ALL QUESTIONS AS A LIST FOR THE PAGEVIEW
  List<Question> get questions {
    List<Question> questionList = [];
    for (var category in inspectionReport.categories) {
      questionList += category.questions;
    }
    return questionList;
  }

  // INDEX OF THE LAST ANSWERED QUESTION (STARTING FROM  0)
  int get lastAnsweredQuestion {
    int lastAnsweredQuestionCount = 0;
    for (var question in this.questions) {
      if (question.answer!.id != 0 && question.actionsCompleted()) {
        lastAnsweredQuestionCount++;
      } else {
        print(lastAnsweredQuestionCount);
        return lastAnsweredQuestionCount;
      }
    }

    return lastAnsweredQuestionCount;
  }

  // PAGECOUNT OF PAGEVIEW (STARTING FROM 1)
  int get pageLimit {
    if (lastAnsweredQuestion != this.questionCount) {
      return lastAnsweredQuestion + 1;
    } else {
      return lastAnsweredQuestion;
    }
  }

  // GET THE TOTAL COUNT OF QUESTIONS
  int get questionCount => questions.length;

  // GET THE CURRENT PAGE INDEX
  int get currentPageIndex =>
      pageController.hasClients && pageController.position.haveDimensions
          ? pageController.page!.round()
          : 0;

  // GET THE CURRENT QUESTION
  Question get currentQuestion => questions[currentPageIndex];

  // GET THE CURRENT CATEGORY
  Category get currentCategory {
    for (var category in inspectionReport.categories) {
      if (this.currentQuestion.categoryTemplateId == category.id) {
        return category;
      }
    }
    return inspectionReport.categories[0];
  }

  PageController pageController = PageController(initialPage: 0);

  bool isLastPage() => this.currentPageIndex + 1 == this.questionCount;

  int imagesToTake() {
    return this
        .currentQuestion
        .imageAction!
        .actionData
        .map(
          (element) {
            if (element.isRequired) {
              return element;
            }
          },
        )
        .toList()
        .length;
  }

  int missingImages() {
    int imagesTaken = 0;

    for (int i = 0;
        i < this.currentQuestion.imageAction!.actionData.length;
        i++) {
      for (int z = 0;
          z < this.currentQuestion.categoryQuestionData.length;
          z++) {
        if (this.currentQuestion.imageAction!.actionData[i].id ==
            this.currentQuestion.categoryQuestionData[z].actionData!.id) {
          imagesTaken++;
        }
      }
    }
    return imagesTaken;
  }

  void addAllChecklistData() {
    // ONLY ADD CHECKLIST DATA FOR FIRST TIME, NOT ON EVERY ANSWER CLICK
    if (this.currentQuestion.categoryQuestionData.length == 0) {
      for (var actionData in currentQuestion.checklistAction!.actionData) {
        currentQuestion.categoryQuestionData.add(
          CategoryQuestionData(
            "0",
            actionData,
            this.currentQuestion.checklistAction,
          ),
        );
      }
    }
  }

  void selectAnswer(Answer answer) {
    this.currentQuestion.answer = answer;
    if (currentQuestion.hasAction) {
      // HAS CHECKLIST -> ADD ALL CHECKLIST ENTRIES WITH NONCHECKED AS DEFAULT
      if (currentQuestion.checklistAction != null) {
        addAllChecklistData();
      }
      animateUp();
    } else {
      if (currentPageIndex + 1 != questionCount) {
        goToNextQuestion();
      } else {
        animateDown();
      }
    }
  }

  void animateUp() {
    this.currentQuestion.questionPosition =
        MediaQuery.of(context).size.height * 0.11;
    this.currentQuestion.answersPosition =
        MediaQuery.of(context).size.height * 0.22;
    setState(state: STATE.SUCCESS);
  }

  void animateDown() {
    this.currentQuestion.questionPosition =
        MediaQuery.of(context).size.height * 0.3;
    this.currentQuestion.answersPosition =
        MediaQuery.of(context).size.height * 0.6;
    setState(state: STATE.SUCCESS);
  }

  void selectChecklist(ActionData actionData, bool value) {
    for (var categoryQuestionData in currentQuestion.categoryQuestionData) {
      if (categoryQuestionData.actionData!.id == actionData.id) {
        if (categoryQuestionData.data == "0") {
          categoryQuestionData.data = "1";
        } else {
          categoryQuestionData.data = "0";
        }
      }
    }

    setState(state: STATE.SUCCESS);
  }

  void goToNextQuestion({bool triggerAnimateDownAnimation = true}) {
    if (triggerAnimateDownAnimation) {
      animateDown();
      Future.delayed(
        Duration(milliseconds: 500),
        () => pageController.nextPage(
            duration: Duration(milliseconds: 300), curve: Curves.easeIn),
      );
    } else {
      pageController.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }

  void goToPage(int index) {
    pageController.jumpToPage(index);
  }

  void takePictures() async {
    List<CameraPicture> images = await Navigator.pushNamed(
      context,
      Constants.ROUTE_CAMERA,
      arguments: Camera(
        CameraType.MOVEMENT,
        this
            .currentQuestion
            .imageAction!
            .actionData
            .map((e) => e.dataName)
            .toList(),
        null,
        null,
      ),
    ) as List<CameraPicture>;

    // DELETE OLD IMAGES
    if (images.isNotEmpty) {
      this.currentQuestion.categoryQuestionData = [];
    }

    // FIND OR MAKE IMAGES TO ACTIONDATA AND ADD THEM
    for (int i = 0; i < images.length; i++) {
      for (int z = 0;
          z < this.currentQuestion.imageAction!.actionData.length;
          z++) {
        if (images[i].tag ==
            this.currentQuestion.imageAction!.actionData[z].dataName) {
          this.currentQuestion.categoryQuestionData.add(
                CategoryQuestionData(
                  images[i].base64,
                  this.currentQuestion.imageAction!.actionData[z],
                  this.currentQuestion.imageAction,
                ),
              );
        } else {
          this.currentQuestion.categoryQuestionData.add(
                CategoryQuestionData(
                  images[i].base64,
                  ActionData(
                    0,
                    "",
                    "",
                    false,
                    10,
                  ),
                  this.currentQuestion.imageAction,
                ),
              );
        }
      }
    }
    setState(state: STATE.SUCCESS);
  }

  void goToPdfPreviewPage() {
    Navigator.pushNamed(context, Constants.ROUTE_MOVEMENT_PROTOCOL_PDF_PREVIEW,
        arguments: this.inspectionReport);
  }
}
