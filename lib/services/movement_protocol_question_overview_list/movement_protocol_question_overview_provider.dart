import 'package:easyrent/core/state_provider.dart';

import 'package:easyrent/models/inspection_report.dart';
import 'package:easyrent/models/question.dart';

class MovementProtocolQuestionOverviewProvider extends StateProvider {
  late InspectionReport inspectionReport;
  List<Question> questions = [];

  MovementProtocolQuestionOverviewProvider(this.inspectionReport) {
    for (var category in inspectionReport.categories) {
      for (var question in category.questions) {
        questions.add(question);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
