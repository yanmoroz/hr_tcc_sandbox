import '../entities/survey_response.dart';
import '../repositories/surveys_repository.dart';

class SubmitSurveyResponseUseCase {
  final SurveysRepository _repository;

  SubmitSurveyResponseUseCase(this._repository);

  Future<void> call(String surveyId, List<SurveyResponse> responses) =>
      _repository.submitSurveyResponse(surveyId, responses);
}
