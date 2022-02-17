import 'package:easyrent/models/category_question_action_data.dart';
import 'package:easyrent/models/question_template.dart';

import 'action_data.dart';
import 'answer.dart';

class Question {
  int id;
  QuestionTemplate? questionTemplate;
  Answer? answer;
  List<CategoryQuestionData> actionsData;
  int categoryTemplateId;
  Question(this.id, this.questionTemplate, this.answer, this.actionsData,
      this.categoryTemplateId);

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
      "actions_data": actionsData,
    };
  }
}
