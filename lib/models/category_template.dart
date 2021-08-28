import 'package:easyrent/models/template_question.dart';

class CategoryTemplate {
  int id;
  String categoryName;
  String categoryTag;
  List<TemplateQuestion> templateQuestions;

  CategoryTemplate(
      this.id, this.categoryName, this.categoryTag, this.templateQuestions);

  factory CategoryTemplate.fromJson(Map<String, dynamic> json) {
    return CategoryTemplate(
      json["id"],
      json["category_name"],
      json["category_tag"],
      json["template_questions"] != null
          ? json["template_questions"]
              .map<TemplateQuestion>(
                (element) => TemplateQuestion.fromJson(element),
              )
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "category_name": categoryName,
      "category_tag": categoryTag,
      "template_questions": List<TemplateQuestion>.from(
        templateQuestions.map(
          (x) => x.toJson(),
        ),
      ),
    };
  }
}
