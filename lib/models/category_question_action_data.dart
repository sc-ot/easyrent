import 'package:easyrent/models/action.dart';
import 'package:easyrent/models/action_data.dart';

class CategoryQuestionData {
  String data;
  ActionData? actionData;
  Action? action;

  CategoryQuestionData(this.data, this.actionData, this.action);

  factory CategoryQuestionData.fromJson(Map<String, dynamic> json) {
    return CategoryQuestionData(
      json["data"] ?? "",
      json["action_template_data"] != null
          ? ActionData.fromJson(json["action_template_data"])
          : null,
      json["action_template"] != null
          ? Action.fromJson(json["action_template"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "data": data,
      "action_template_data": actionData,
      "action_template": action,
    };
  }
}
