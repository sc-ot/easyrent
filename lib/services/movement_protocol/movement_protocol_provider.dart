import 'dart:async';

import 'package:easyrent/core/constants.dart';
import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/models/action_data.dart';
import 'package:easyrent/models/answer.dart';
import 'package:easyrent/models/camera.dart';
import 'package:easyrent/models/camera_picture.dart';
import 'package:easyrent/models/category.dart';
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
    this.questionPosition = MediaQuery.of(context).size.height * 0.3;
    this.answersPosition = MediaQuery.of(context).size.height * 0.6;
  }

  int get lastAnsweredQuestion {
    int lastAnsweredQuestionCount = 0;
    for (var category in inspectionReport.categories) {
      for (var question in category.questions) {
        if (question.answer!.id != 0 && actionsCompleted(question: question)) {
          lastAnsweredQuestionCount++;
        } else {
          return lastAnsweredQuestionCount;
        }
      }
    }

    return lastAnsweredQuestionCount;
  }

  int get questionCount {
    int questionCount = 0;
    for (var category in inspectionReport.categories) {
      questionCount += category.questions.length;
    }
    return questionCount;
  }

  int get currentPageIndex =>
      pageController.hasClients && pageController.position.haveDimensions
          ? pageController.page!.round()
          : 0;

  bool get answerSelected {
    return currentQuestion.answer != null && currentQuestion.answer!.id != 0;
  }

  bool get questionAnswered {
    return currentQuestion.answer?.actions.isEmpty ?? false;
  }

  Question get currentQuestion {
    List<Question> questions = [];
    for (var category in inspectionReport.categories) {
      questions += category.questions;
    }
    return questions[currentPageIndex];
  }

  Category get currentCategory {
    for (var category in inspectionReport.categories) {
      if (this.currentQuestion.categoryTemplateId == category.id) {
        return category;
      }
    }
    return inspectionReport.categories[0];
  }

  PageController pageController = PageController(initialPage: 0);

  double questionPosition = 0.0;
  double answersPosition = 0.0;

  void updatePage() {
    if (this.currentQuestion.answer != null &&
        this.currentQuestion.answer!.actions.isEmpty) {
      animateDown();
    } else {
      animateUp();
    }
    setState(state: STATE.SUCCESS);
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

  // get the checklistAction of the selected answer, null if not found
  ir.Action? get checklistAction {
    ir.Action? checklist;
    if (answerSelected) {
      currentQuestion.answer!.actions.forEach(
        (action) {
          if (action.actionType == "CHECKLIST") {
            checklist = action;
          }
        },
      );
    }
    return checklist;
  }

  // get the imageAction of the selected answer, null if not found
  ir.Action? get imageAction {
    ir.Action? image;
    if (answerSelected) {
      currentQuestion.answer!.actions.forEach(
        (action) {
          if (action.actionType == "IMAGES") {
            image = action;
          }
        },
      );
    }
    return image;
  }

  bool actionsCompleted({Question? question}) {
    if (question == null) {
      question = currentQuestion;
    }
    bool actionsCompleted = true;
    int requiredActionDataCount = 0;

    for (var action in question.answer!.actions) {
      for (var actionData in action.actionData) {
        if (actionData.isRequired) {
          requiredActionDataCount++;
          bool actionDataFound = false;
          for (var addedActionData in question.actionsData) {
            if (addedActionData.isRequired &&
                addedActionData.id == actionData.id) {
              actionDataFound = true;
            }
          }
          if (!actionDataFound) {
            return false;
          }
        }
      }
    }

    // REQUIRED ACTIONDATA COUNT NOT SAME AS ADDED ACTIONS
    if (requiredActionDataCount <
        this.requiredActionData(question: question).length) {
      return false;
    }
    return actionsCompleted;
  }

  List<ActionData> requiredActionData({Question? question}) {
    if (question == null) {
      question = currentQuestion;
    }
    List<ActionData> requiredActionData = [];
    question.actionsData.forEach(
      (element) {
        if (element.isRequired) {
          requiredActionData.add(element);
        }
      },
    );
    return requiredActionData;
  }

  int imagesToTake() {
    return this
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

  bool isLastPage() => this.questionCount == this.lastAnsweredQuestion;

  int missingImages() {
    int imagesTaken = 0;
    this.imageAction!.actionData.forEach(
      (actionDataToTake) {
        bool imageFound = this.currentQuestion.actionsData.contains(
              actionDataToTake,
            );
        if (imageFound) {
          imagesTaken++;
        }
      },
    );
    return imagesTaken;
  }

  void animateUp() {
    this.questionPosition = MediaQuery.of(context).size.height * 0.11;
    this.answersPosition = MediaQuery.of(context).size.height * 0.22;
    setState(state: STATE.SUCCESS);
  }

  void animateDown() {
    this.questionPosition = MediaQuery.of(context).size.height * 0.3;
    this.answersPosition = MediaQuery.of(context).size.height * 0.6;
    setState(state: STATE.SUCCESS);
  }

  void selectAnswer(Answer answer) {
    this.currentQuestion.answer = answer;
    updatePage();
    if (this.currentQuestion.answer!.actions.isEmpty) {
      Future.delayed(
        Duration(milliseconds: 500),
        () {
          goToNextQuestion();
        },
      );
    }
  }

  void selectChecklist(int index, bool value) {
    this.checklistAction!.actionData[index].tempValue = value;
    currentQuestion.actionsData.add(this.checklistAction!.actionData[index]);
    updatePage();
  }

  void goToNextQuestion() {
    if (this.lastAnsweredQuestion == this.questionCount) {
      Navigator.pushNamed(
          context, Constants.ROUTE_MOVEMENT_PROTOCOL_QUESTION_OVERVIEW);
    }
    if (this.currentQuestion.answer!.actions.isEmpty) {
      pageController.nextPage(
          duration: Duration(milliseconds: 500), curve: Curves.easeIn);
    } else {
      animateDown();
      Future.delayed(
        Duration(milliseconds: 500),
        () {
          pageController.nextPage(
              duration: Duration(milliseconds: 500), curve: Curves.easeIn);
        },
      );
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
        this.imageAction!.actionData.map((e) => e.dataName).toList(),
        null,
        null,
      ),
    ) as List<CameraPicture>;

    // DELETE OLD IMAGES
    if (images.isNotEmpty) {
      this.currentQuestion.actionsData = [];
    }

    // FIND OR MAKE IMAGES TO ACTIONDATA AND ADD THEM
    for (int i = 0; i < images.length; i++) {
      for (int z = 0; z < this.imageAction!.actionData.length; z++) {
        if (images[i].tag == imageAction!.actionData[z].dataName) {
          this.currentQuestion.actionsData.add(imageAction!.actionData[z]);
        } else {
          this.currentQuestion.actionsData.add(
                ActionData(
                  0,
                  images[i].tag,
                  images[i].base64,
                  false,
                  10,
                ),
              );
        }
      }
    }

    updatePage();
  }

  bool isAnswerSelected(Answer answer) {
    return currentQuestion.answer != null &&
        currentQuestion.answer!.id == answer.id;
  }

  void goToPreviewPage() {
    Navigator.pushNamed(context, Constants.ROUTE_LOGIN);
  }
}
