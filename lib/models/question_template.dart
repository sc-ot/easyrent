import 'package:easyrent/models/template_question.dart';

import 'answer.dart';

class QuestionTemplate extends TemplateQuestion {
  QuestionTemplate(int id, String questionText, String questionTag,
      bool isRequired, String questionType, List<Answer> answers)
      : super(id, questionText, questionTag, isRequired, questionType, answers);

  factory QuestionTemplate.fromJson(Map<String, dynamic> json) {
    return QuestionTemplate(
      json["id"],
      json["question_text"],
      json["question_tag"],
      json["required"],
      json["question_type"],
      json["answers"] != null
          ? json["answers"]
              .map<Answer>((element) => Answer.fromJson(element))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "question_text": questionText,
      "question_tag": questionTag,
      "required": isRequired,
      "question_type": questionType,
      "answers": List<Answer>.from(
        answers.map(
          (x) => x.toJson(),
        ),
      ),
    };
  }
}
