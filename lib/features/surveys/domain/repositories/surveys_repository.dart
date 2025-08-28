import '../entities/survey.dart';
import '../entities/survey_detail.dart';
import '../entities/survey_answer.dart';

abstract class SurveysRepository {
  Future<List<Survey>> getSurveys();
  Future<SurveyDetail> getSurveyDetail(String surveyId);
  Future<void> submitSurveyResponse(
    String surveyId,
    List<SurveyAnswer> answers,
  );
}
