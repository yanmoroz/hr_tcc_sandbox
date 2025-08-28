// Base abstract class for all question types
abstract class SurveyQuestion {
  final String id;
  final String title;
  final String? description;
  final bool isRequired;

  const SurveyQuestion({
    required this.id,
    required this.title,
    this.description,
    this.isRequired = false,
  });
}

// Text input question (single line)
class TextQuestion extends SurveyQuestion {
  final String? placeholder;

  const TextQuestion({
    required super.id,
    required super.title,
    super.description,
    super.isRequired = false,
    this.placeholder,
  });
}

// Multiline text input question
class MultilineQuestion extends SurveyQuestion {
  final String? placeholder;

  const MultilineQuestion({
    required super.id,
    required super.title,
    super.description,
    super.isRequired = false,
    this.placeholder,
  });
}

// Single select question with radio buttons
class SingleSelectQuestion extends SurveyQuestion {
  final List<QuestionOption> options;

  const SingleSelectQuestion({
    required super.id,
    required super.title,
    super.description,
    super.isRequired = false,
    required this.options,
  });

  @override
  String toString() {
    if (options.isEmpty) {
      throw ArgumentError(
        'Options cannot be empty for single select questions',
      );
    }
    return super.toString();
  }
}

// Question option for select-type questions
class QuestionOption {
  final String id;
  final String text;
  final String? value;

  const QuestionOption({required this.id, required this.text, this.value});
}
