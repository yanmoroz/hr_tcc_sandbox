import '../../domain/entities/survey_detail.dart';
import '../../domain/entities/survey_question.dart';

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
          .map((q) => _questionFromJson(q as Map<String, dynamic>))
          .toList(),
      headerText: json['headerText'] as String?,
    );
  }

  static SurveyQuestion _questionFromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;

    switch (type) {
      case 'text':
        return TextQuestion(
          id: json['id'] as String,
          title: json['title'] as String,
          description: json['description'] as String?,
          isRequired: json['isRequired'] as bool? ?? false,
          placeholder: json['placeholder'] as String?,
        );
      case 'multiline':
        return MultilineQuestion(
          id: json['id'] as String,
          title: json['title'] as String,
          description: json['description'] as String?,
          isRequired: json['isRequired'] as bool? ?? false,
          placeholder: json['placeholder'] as String?,
        );
      case 'singleSelect':
        final options = (json['options'] as List<dynamic>)
            .map(
              (optionJson) => QuestionOption(
                id: optionJson['id'] as String,
                text: optionJson['text'] as String,
                value: optionJson['value'] as String?,
              ),
            )
            .toList();
        return SingleSelectQuestion(
          id: json['id'] as String,
          title: json['title'] as String,
          description: json['description'] as String?,
          isRequired: json['isRequired'] as bool? ?? false,
          options: options,
        );
      default:
        return TextQuestion(
          id: json['id'] as String,
          title: json['title'] as String,
          description: json['description'] as String?,
          isRequired: json['isRequired'] as bool? ?? false,
          placeholder: json['placeholder'] as String?,
        );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'timestamp': timestamp,
      'questions': questions.map((q) => _questionToJson(q)).toList(),
      'headerText': headerText,
    };
  }

  static Map<String, dynamic> _questionToJson(SurveyQuestion question) {
    final baseJson = {
      'id': question.id,
      'title': question.title,
      'description': question.description,
      'isRequired': question.isRequired,
    };

    return switch (question) {
      TextQuestion q => {
        ...baseJson,
        'type': 'text',
        'placeholder': q.placeholder,
      },
      MultilineQuestion q => {
        ...baseJson,
        'type': 'multiline',
        'placeholder': q.placeholder,
      },
      SingleSelectQuestion q => {
        ...baseJson,
        'type': 'singleSelect',
        'options': q.options
            .map(
              (option) => {
                'id': option.id,
                'text': option.text,
                'value': option.value,
              },
            )
            .toList(),
      },
      _ => {...baseJson, 'type': 'text'},
    };
  }
}
