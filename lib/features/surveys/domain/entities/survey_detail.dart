import 'survey_question.dart';

class SurveyDetail {
  final String id;
  final String title;
  final String? description;
  final String? imageUrl;
  final String timestamp;
  final List<SurveyQuestion> questions;
  final String? headerText;

  const SurveyDetail({
    required this.id,
    required this.title,
    this.description,
    this.imageUrl,
    required this.timestamp,
    required this.questions,
    this.headerText,
  });
}
