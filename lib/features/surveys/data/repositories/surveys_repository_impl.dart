import '../../domain/entities/survey.dart';
import '../../domain/repositories/surveys_repository.dart';
import '../datasources/surveys_local_datasource.dart';

class SurveysRepositoryImpl implements SurveysRepository {
  final SurveysLocalDataSource _localDataSource;

  SurveysRepositoryImpl(this._localDataSource);

  @override
  Future<List<Survey>> getSurveys() => _localDataSource.getSurveys();
}
