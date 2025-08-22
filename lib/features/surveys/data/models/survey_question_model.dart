import '../../domain/entities/survey_question.dart';

class SurveyQuestionModel extends SurveyQuestion {
  const SurveyQuestionModel({
    required super.id,
    required super.title,
    super.description,
    required super.type,
    super.isRequired,
    super.placeholder,
  });

  factory SurveyQuestionModel.fromJson(Map<String, dynamic> json) {
    return SurveyQuestionModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      type: QuestionType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => QuestionType.text,
      ),
      isRequired: json['isRequired'] as bool? ?? false,
      placeholder: json['placeholder'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type.name,
      'isRequired': isRequired,
      'placeholder': placeholder,
    };
  }
}
