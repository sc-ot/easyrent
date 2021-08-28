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
      json["id"],
      json["category_template"] != null
          ? CategoryTemplate.fromJson(json["category_template"])
          : null,
      json["questions"] != null
          ? json["questions"]
              .map<Question>((element) => Question.fromJson(element))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "category_template": categoryTemplate?.toJson(),
      "questions": List<Question>.from(
        questions.map(
          (x) => x.toJson(),
        ),
      ),
    };
  }
}
