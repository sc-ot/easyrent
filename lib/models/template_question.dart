
import 'answer.dart';

class TemplateQuestion {
  int id;
  String questionText;
  String questionTag;
  bool isRequired;
  String questionType;
  List<Answer> answers;

  TemplateQuestion(this.id, this.questionText, this.questionTag,
      this.isRequired, this.questionType, this.answers);

  factory TemplateQuestion.fromJson(Map<String, dynamic> json) {
    return TemplateQuestion(
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
