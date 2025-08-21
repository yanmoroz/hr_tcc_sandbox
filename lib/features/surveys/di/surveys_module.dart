import 'package:get_it/get_it.dart';

import '../../../app/di/di_module.dart';
import '../data/datasources/surveys_local_datasource.dart';
import '../data/repositories/surveys_repository_impl.dart';
import '../domain/repositories/surveys_repository.dart';
import '../domain/usecases/get_surveys.dart';
import '../presentation/blocs/surveys_bloc.dart';

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
    getIt.registerFactory<SurveysBloc>(
      () => SurveysBloc(getSurveys: getIt<GetSurveysUseCase>()),
    );
  }
}
