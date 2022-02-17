import 'package:easyrent/models/question.dart';

import 'category_template.dart';

class Category {
  int id;
  CategoryTemplate? categoryTemplate;
  List<Question> questions;

  Category(
    this.id,
    this.categoryTemplate,
    this.questions,
  );

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      json["category_template"] != null
          ? json["category_template"]["id"] ?? 0
          : 0,
      json["category_template"] != null
          ? CategoryTemplate.fromJson(json["category_template"])
          : null,
      json["questions"] != null
          ? json["questions"].map<Question>((element) {
              Question question = Question.fromJson(element);
              question.categoryTemplateId = json["category_template"] != null
                  ? json["category_template"]["id"] ?? 0
                  : 0;
              return question;
            }).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "category_template": categoryTemplate,
      "questions": questions,
    };
  }
}
