import 'package:easyrent/core/application.dart';
import 'package:easyrent/models/action.dart';
import 'package:easyrent/models/action_data.dart';
import 'package:easyrent/models/category_question_action_data.dart';
import 'package:easyrent/models/question_template.dart';
import 'package:easyrent/services/movement_protocol/movement_protocol_provider.dart';
import 'package:flutter/material.dart' as material;

import 'answer.dart';

class Question {
  int id;
  QuestionTemplate? questionTemplate;
  Answer? answer;
  List<CategoryQuestionData> categoryQuestionData;
  int categoryTemplateId;
  double questionPosition = 0.0;
  double answersPosition = 0.0;

  Question(
    this.id,
    this.questionTemplate,
    this.answer,
    this.categoryQuestionData,
    this.categoryTemplateId,
  );

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      json["id"],
      json["question_template"] != null
          ? QuestionTemplate.fromJson(json["question_template"])
          : null,
      json["answer"] != null ? Answer.fromJson(json["answer"]) : null,
      json["actions_data"] != null
          ? json["actions_data"]
              .map<CategoryQuestionData>(
                  (element) => CategoryQuestionData.fromJson(element))
              .toList()
          : [],
      0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "question_template": questionTemplate?.toJson(),
      "answer": answer?.toJson(),
      "actions_data": categoryQuestionData,
    };
  }

  bool get answerSelected {
    return this.answer != null && this.answer!.id != 0;
  }

  Action? get checklistAction {
    Action? checklist;
    if (answerSelected) {
      answer!.actions.forEach(
        (action) {
          if (action.actionType == "CHECKLIST") {
            checklist = action;
          }
        },
      );
    }
    return checklist;
  }

  Action? get imageAction {
    Action? image;
    if (answerSelected) {
      answer!.actions.forEach(
        (action) {
          if (action.actionType == "IMAGES") {
            image = action;
          }
        },
      );
    }
    return image;
  }

  bool actionsCompleted() {
    bool actionsCompleted = true;
    int requiredActionDataCount = 0;

    for (var action in this.answer!.actions) {
      for (var actionData in action.actionData) {
        if (actionData.isRequired) {
          requiredActionDataCount++;
          bool actionDataFound = false;
          for (var addedActionData in this.categoryQuestionData) {
            if (addedActionData.actionData!.isRequired &&
                addedActionData.actionData!.id == actionData.id) {
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
    if (requiredActionDataCount < this.requiredActionData().length) {
      return false;
    }
    return actionsCompleted;
  }

  List<ActionData> requiredActionData() {
    List<ActionData> requiredActionData = [];
    this.categoryQuestionData.forEach(
      (element) {
        if (element.actionData!.isRequired) {
          requiredActionData.add(element.actionData!);
        }
      },
    );
    return requiredActionData;
  }

  bool isAnswerSelected(Answer answer) {
    return this.answer != null && this.answer!.id == answer.id;
  }

  bool get questionAnswered {
    return this.answer?.actions.isEmpty ?? false;
  }

  bool get hasAction => this.answer != null && this.answer!.actions.isNotEmpty;

  bool isCheckListEntrySelected(ActionData actionData) {
    for (var categoryQuestionData in categoryQuestionData) {
      if (categoryQuestionData.actionData!.id == actionData.id &&
          categoryQuestionData.data == "1") {
        return true;
      }
    }
    return false;
  }
}
