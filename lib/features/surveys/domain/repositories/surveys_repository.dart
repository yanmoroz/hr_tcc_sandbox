import '../entities/survey.dart';

abstract class SurveysRepository {
  Future<List<Survey>> getSurveys();
}
