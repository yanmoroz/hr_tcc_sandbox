import '../../domain/entities/survey_detail.dart';
import 'survey_question_model.dart';

class SurveyDetailModel extends SurveyDetail {
  const SurveyDetailModel({
    required super.id,
    required super.title,
    super.description,
    super.imageUrl,
    required super.timestamp,
    required super.questions,
    super.headerText,
  });

  factory SurveyDetailModel.fromJson(Map<String, dynamic> json) {
    return SurveyDetailModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      timestamp: json['timestamp'] as String,
      questions: (json['questions'] as List<dynamic>)
          .map((q) => SurveyQuestionModel.fromJson(q as Map<String, dynamic>))
          .toList(),
      headerText: json['headerText'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'timestamp': timestamp,
      'questions': questions
          .map((q) => (q as SurveyQuestionModel).toJson())
          .toList(),
      'headerText': headerText,
    };
  }
}
