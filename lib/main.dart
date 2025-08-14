import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

// Profile feature imports
import 'features/profile/data/datasources/profile_remote_datasource.dart';
import 'features/profile/data/datasources/kpi_remote_datasource.dart';
import 'features/profile/data/repositories/profile_repository_impl.dart';
import 'features/profile/data/repositories/kpi_repository_impl.dart';
import 'features/profile/domain/repositories/profile_repository.dart';
import 'features/profile/domain/repositories/kpi_repository.dart';
import 'features/profile/domain/usecases/get_profile.dart';
import 'features/profile/domain/usecases/update_profile.dart' as usecase;
import 'features/profile/domain/usecases/get_kpis.dart';
import 'features/profile/presentation/blocs/profile_bloc.dart';
import 'features/profile/presentation/blocs/profile_event.dart';
import 'features/profile/presentation/blocs/kpi_bloc.dart';

// Auth feature imports
import 'features/auth/presentation/blocs/auth_bloc.dart';

// Router import
import 'app/router/app_router.dart';
import 'app/di/auth_injection.dart';

final GetIt getIt = GetIt.instance;

void main() {
  setupDependencies();
  runApp(const MainApp());
}

void setupDependencies() {
  // Setup auth dependencies
  setupAuthDependencies(getIt);

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
  getIt.registerLazySingleton(() => GetProfile(getIt<ProfileRepository>()));
  getIt.registerLazySingleton(
    () => usecase.UpdateProfile(getIt<ProfileRepository>()),
  );
  getIt.registerLazySingleton(() => GetKpis(getIt<KpiRepository>()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => getIt<AuthBloc>()),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(
            getProfile: getIt<GetProfile>(),
            updateProfile: getIt<usecase.UpdateProfile>(),
          )..add(const LoadProfile('1')),
        ),
        BlocProvider<KpiBloc>(
          create: (context) => KpiBloc(getKpis: getIt<GetKpis>()),
        ),
      ],
      child: MaterialApp.router(
        title: 'HR TCC Sandbox',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
            elevation: 0,
          ),
          scaffoldBackgroundColor: Colors.grey[50],
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
