import 'file_attachment.dart';

class SurveyAnswer {
  final String questionId;
  final String answer;
  final FileAttachment? attachedFile;

  const SurveyAnswer({
    required this.questionId,
    required this.answer,
    this.attachedFile,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SurveyAnswer &&
        other.questionId == questionId &&
        other.answer == answer &&
        other.attachedFile == attachedFile;
  }

  @override
  int get hashCode {
    return Object.hash(questionId, answer, attachedFile);
  }

  @override
  String toString() {
    return 'SurveyAnswer(questionId: $questionId, answer: $answer, attachedFile: $attachedFile)';
  }
}
