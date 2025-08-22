import '../entities/survey_detail.dart';
import '../repositories/surveys_repository.dart';

class GetSurveyDetailUseCase {
  final SurveysRepository _repository;

  GetSurveyDetailUseCase(this._repository);

  Future<SurveyDetail> call(String surveyId) =>
      _repository.getSurveyDetail(surveyId);
}
