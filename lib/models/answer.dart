import 'action.dart';

class Answer {
  int id;
  String answerText;
  String answerType;
  int answerValue;
  int orderValue;
  List<Action> actions;

  Answer(
    this.id,
    this.answerText,
    this.answerType,
    this.answerValue,
    this.orderValue,
    this.actions,
  );

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      json["id"],
      json["answer_text"],
      json["answer_type"],
      json["answer_value"],
      json["order_value"],
      json["actions"] != null
          ? json["actions"]
              .map<Action>(
                (element) => Action.fromJson(element),
              )
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "answer_text": answerText,
      "answer_type": answerType,
      "answer_value": answerValue,
      "order_value": orderValue,
      "actions": List<Action>.from(
        actions.map(
          (x) => x.toJson(),
        ),
      ),
    };
  }
}
