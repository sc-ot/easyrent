import 'action_data.dart';

class Action {
  int id;
  String actionType;
  String actionTag;
  String actionName;
  bool isRequired;
  List<ActionData> actionData;

  Action(
    this.id,
    this.actionType,
    this.actionTag,
    this.actionName,
    this.isRequired,
    this.actionData,
  );

  factory Action.fromJson(Map<String, dynamic> json) {
    return Action(
      json["id"],
      json["action_type"],
      json["action_tag"],
      json["action_name"],
      json["required"],
      json["action_data"] != null
          ? json["action_data"]
              .map<ActionData>((element) => ActionData.fromJson(element))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "action_type": actionType,
      "action_tag": actionTag,
      "action_name": actionName,
      "required": isRequired,
      "action_data": actionData,
    };
  }
}
