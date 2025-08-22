enum QuestionType { text, multiline }

class SurveyQuestion {
  final String id;
  final String title;
  final String? description;
  final QuestionType type;
  final bool isRequired;
  final String? placeholder;

  const SurveyQuestion({
    required this.id,
    required this.title,
    this.description,
    required this.type,
    this.isRequired = false,
    this.placeholder,
  });
}
