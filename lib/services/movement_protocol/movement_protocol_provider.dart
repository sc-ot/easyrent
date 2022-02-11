import 'dart:async';

import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/models/category.dart';
import 'package:easyrent/models/inspection_report.dart';
import 'package:easyrent/models/question.dart';
import 'package:flutter/cupertino.dart';

class MovementProtocolProvider extends StateProvider {
  late InspectionReport inspectionReport;

  MovementProtocolProvider(this.inspectionReport);

  int get questionCount {
    int questionCount = 0;
    for (var category in inspectionReport.categories) {
      questionCount += category.questions.length;
    }
    return questionCount;
  }

  int get currentPageIndex {
    return pageController.hasClients && pageController.position.haveDimensions
        ? pageController.page!.round()
        : 0;
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

  void updatePage(int index) {
    setState(state: STATE.SUCCESS);
  }

  Future<bool> initializeController() {
    Completer<bool> completer = new Completer<bool>();

    /// Callback called after widget has been fully built
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      completer.complete(true);
    });

    return completer.future;
  }
}
