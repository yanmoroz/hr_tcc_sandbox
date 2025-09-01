import 'package:get_it/get_it.dart';

import '../../../app/di/di_module.dart';
import '../data/datasources/applications_local_datasource.dart';
import '../data/repositories/applications_repository_impl.dart';
import '../domain/repositories/applications_repository.dart';
import '../domain/usecases/get_application_categories.dart';
import '../domain/usecases/get_application_templates.dart';
import '../domain/usecases/get_application_purposes.dart';
import '../domain/usecases/get_applications.dart';
import '../domain/usecases/get_application.dart';
import '../domain/usecases/create_application.dart';
import '../presentation/blocs/applications_bloc.dart';
import '../presentation/blocs/new_application_bloc.dart';
import '../presentation/blocs/applications_list_bloc.dart';
import '../presentation/blocs/application_detail_bloc.dart';
import '../presentation/blocs/applications_widget_cubit.dart';

class ApplicationsModule extends DiModule {
  @override
  void register(GetIt getIt) {
    getIt.registerLazySingleton<ApplicationsLocalDataSource>(
      () => ApplicationsLocalDataSourceImpl(),
    );
    getIt.registerLazySingleton<ApplicationsRepository>(
      () => ApplicationsRepositoryImpl(getIt<ApplicationsLocalDataSource>()),
    );
    getIt.registerLazySingleton<GetApplicationCategoriesUseCase>(
      () => GetApplicationCategoriesUseCase(getIt<ApplicationsRepository>()),
    );
    getIt.registerLazySingleton<GetApplicationTemplatesUseCase>(
      () => GetApplicationTemplatesUseCase(getIt<ApplicationsRepository>()),
    );
    getIt.registerLazySingleton<GetApplicationPurposesUseCase>(
      () => GetApplicationPurposesUseCase(getIt<ApplicationsRepository>()),
    );
    getIt.registerLazySingleton<GetApplicationsUseCase>(
      () => GetApplicationsUseCase(getIt<ApplicationsRepository>()),
    );
    getIt.registerLazySingleton<GetApplicationUseCase>(
      () => GetApplicationUseCase(getIt<ApplicationsRepository>()),
    );
    getIt.registerLazySingleton<CreateApplicationUseCase>(
      () => CreateApplicationUseCase(getIt<ApplicationsRepository>()),
    );
    getIt.registerFactory<ApplicationsBloc>(
      () => ApplicationsBloc(
        getCategories: getIt<GetApplicationCategoriesUseCase>(),
        getTemplates: getIt<GetApplicationTemplatesUseCase>(),
      ),
    );
    getIt.registerFactory<NewApplicationBloc>(
      () => NewApplicationBloc(
        getPurposes: getIt<GetApplicationPurposesUseCase>(),
        create: getIt<CreateApplicationUseCase>(),
      ),
    );
    getIt.registerFactory<ApplicationsListBloc>(
      () => ApplicationsListBloc(
        getApplications: getIt<GetApplicationsUseCase>(),
      ),
    );
    getIt.registerFactory<ApplicationDetailBloc>(
      () =>
          ApplicationDetailBloc(getApplication: getIt<GetApplicationUseCase>()),
    );
    getIt.registerFactory<ApplicationsWidgetCubit>(
      () => ApplicationsWidgetCubit(
        getApplications: getIt<GetApplicationsUseCase>(),
        getTemplates: getIt<GetApplicationTemplatesUseCase>(),
      ),
    );
  }
}
