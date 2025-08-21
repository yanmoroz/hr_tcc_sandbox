import 'package:get_it/get_it.dart';

import '../data/datasources/profile_remote_datasource.dart';
import '../data/datasources/kpi_remote_datasource.dart';
import '../data/repositories/profile_repository_impl.dart';
import '../data/repositories/kpi_repository_impl.dart';
import '../domain/repositories/profile_repository.dart';
import '../domain/repositories/kpi_repository.dart';
import '../domain/usecases/get_profile.dart';
import '../domain/usecases/update_profile.dart' as usecase;
import '../domain/usecases/get_kpis.dart';
import '../presentation/blocs/profile_bloc.dart';
import '../presentation/blocs/kpi_bloc.dart';
import '../../../app/di/di_module.dart';

class ProfileModule extends DiModule {
  @override
  void register(GetIt getIt) {
    // Data sources
    getIt.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(),
    );
    getIt.registerLazySingleton<KpiRemoteDataSource>(
      () => KpiRemoteDataSourceImpl(),
    );

    // Repositories
    getIt.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(getIt<ProfileRemoteDataSource>()),
    );
    getIt.registerLazySingleton<KpiRepository>(
      () => KpiRepositoryImpl(getIt<KpiRemoteDataSource>()),
    );

    // Use cases
    getIt.registerLazySingleton<GetProfile>(
      () => GetProfile(getIt<ProfileRepository>()),
    );
    getIt.registerLazySingleton<usecase.UpdateProfile>(
      () => usecase.UpdateProfile(getIt<ProfileRepository>()),
    );
    getIt.registerLazySingleton<GetKpis>(() => GetKpis(getIt<KpiRepository>()));

    // BLoCs
    getIt.registerFactory<ProfileBloc>(
      () => ProfileBloc(
        getProfile: getIt<GetProfile>(),
        updateProfile: getIt<usecase.UpdateProfile>(),
      ),
    );
    getIt.registerFactory<KpiBloc>(() => KpiBloc(getKpis: getIt<GetKpis>()));
  }
}
