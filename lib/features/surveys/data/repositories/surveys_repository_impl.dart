import '../../domain/entities/survey.dart';
import '../../domain/entities/survey_detail.dart';
import '../../domain/entities/survey_response.dart';
import '../../domain/repositories/surveys_repository.dart';
import '../datasources/surveys_local_datasource.dart';

class SurveysRepositoryImpl implements SurveysRepository {
  final SurveysLocalDataSource _localDataSource;

  SurveysRepositoryImpl(this._localDataSource);

  @override
  Future<List<Survey>> getSurveys() => _localDataSource.getSurveys();

  @override
  Future<SurveyDetail> getSurveyDetail(String surveyId) =>
      _localDataSource.getSurveyDetail(surveyId);

  @override
  Future<void> submitSurveyResponse(
    String surveyId,
    List<SurveyResponse> responses,
  ) => _localDataSource.submitSurveyResponse(surveyId, responses);
}
