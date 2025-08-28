import '../entities/survey_answer.dart';
import '../repositories/surveys_repository.dart';

class SubmitSurveyResponseUseCase {
  final SurveysRepository _repository;

  SubmitSurveyResponseUseCase(this._repository);

  Future<void> call(String surveyId, List<SurveyAnswer> answers) =>
      _repository.submitSurveyResponse(surveyId, answers);
}
