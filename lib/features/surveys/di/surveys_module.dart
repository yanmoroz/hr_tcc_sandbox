import 'package:get_it/get_it.dart';

import '../../../app/di/di_module.dart';
import '../data/datasources/surveys_local_datasource.dart';
import '../data/repositories/surveys_repository_impl.dart';
import '../domain/repositories/surveys_repository.dart';
import '../domain/usecases/get_surveys.dart';
import '../domain/usecases/get_survey_detail.dart';
import '../domain/usecases/submit_survey_response.dart';
import '../presentation/blocs/surveys_bloc.dart';
import '../presentation/blocs/survey_detail_bloc.dart';

class SurveysModule extends DiModule {
  @override
  void register(GetIt getIt) {
    getIt.registerLazySingleton<SurveysLocalDataSource>(
      () => SurveysLocalDataSourceImpl(),
    );
    getIt.registerLazySingleton<SurveysRepository>(
      () => SurveysRepositoryImpl(getIt<SurveysLocalDataSource>()),
    );
    getIt.registerLazySingleton<GetSurveysUseCase>(
      () => GetSurveysUseCase(getIt<SurveysRepository>()),
    );
    getIt.registerLazySingleton<GetSurveyDetailUseCase>(
      () => GetSurveyDetailUseCase(getIt<SurveysRepository>()),
    );
    getIt.registerLazySingleton<SubmitSurveyResponseUseCase>(
      () => SubmitSurveyResponseUseCase(getIt<SurveysRepository>()),
    );
    getIt.registerFactory<SurveysBloc>(
      () => SurveysBloc(getSurveys: getIt<GetSurveysUseCase>()),
    );
    getIt.registerFactory<SurveyDetailBloc>(
      () => SurveyDetailBloc(
        getSurveyDetail: getIt<GetSurveyDetailUseCase>(),
        submitSurveyResponse: getIt<SubmitSurveyResponseUseCase>(),
      ),
    );
  }
}
