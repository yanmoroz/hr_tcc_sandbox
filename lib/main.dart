import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

// Router
import 'app/router/app_router.dart';

// DI modules
import 'app/di/app_module.dart';
import 'app/di/di_module.dart';
import 'features/auth/di/auth_module.dart';
import 'features/profile/di/profile_module.dart';
import 'features/profile/presentation/blocs/kpi_bloc.dart';
import 'features/profile/presentation/blocs/profile_bloc.dart';
import 'features/profile/presentation/blocs/profile_event.dart';
import 'features/quick_links/di/quick_links_module.dart';
import 'features/surveys/di/surveys_module.dart';

final GetIt getIt = GetIt.instance;

void main() {
  setupDependencies();
  runApp(const MainApp());
}

void setupDependencies() {
  final List<DiModule> modules = [
    AppModule(),
    AuthModule(),
    ProfileModule(),
    QuickLinksModule(),
    SurveysModule(),
  ];

  for (final module in modules) {
    module.register(getIt);
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>(
          create: (context) =>
              getIt<ProfileBloc>()..add(const LoadProfile('1')),
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
