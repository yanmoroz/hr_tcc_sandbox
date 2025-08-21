import '../entities/survey.dart';
import '../repositories/surveys_repository.dart';

class GetSurveysUseCase {
  final SurveysRepository _repository;

  GetSurveysUseCase(this._repository);

  Future<List<Survey>> call() => _repository.getSurveys();
}
