import 'package:equatable/equatable.dart';
import '../../domain/entities/survey_answer.dart';

abstract class SurveyDetailEvent extends Equatable {
  const SurveyDetailEvent();
  @override
  List<Object?> get props => [];
}

class SurveyDetailRequested extends SurveyDetailEvent {
  final String surveyId;

  const SurveyDetailRequested(this.surveyId);

  @override
  List<Object?> get props => [surveyId];
}

class SurveyResponseChanged extends SurveyDetailEvent {
  final String questionId;
  final String answer;

  const SurveyResponseChanged(this.questionId, this.answer);

  @override
  List<Object?> get props => [questionId, answer];
}

class SurveySubmitted extends SurveyDetailEvent {
  final String surveyId;
  final List<SurveyAnswer> answers;

  const SurveySubmitted(this.surveyId, this.answers);

  @override
  List<Object?> get props => [surveyId, answers];
}
