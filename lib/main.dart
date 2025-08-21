import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

// BLoCs
import 'features/auth/presentation/blocs/biometric_setup_bloc.dart';
import 'features/profile/presentation/blocs/profile_bloc.dart';
import 'features/profile/presentation/blocs/profile_event.dart';
import 'features/profile/presentation/blocs/kpi_bloc.dart';
import 'features/auth/presentation/blocs/auth_bloc.dart';
import 'features/auth/presentation/blocs/pin_bloc.dart';
import 'features/auth/presentation/blocs/unlock_bloc.dart';

// Router
import 'app/router/app_router.dart';

// DI modules
import 'app/di/app_module.dart';
import 'app/di/di_module.dart';
import 'features/auth/di/auth_module.dart';
import 'features/profile/di/profile_module.dart';

final GetIt getIt = GetIt.instance;

void main() {
  setupDependencies();
  runApp(const MainApp());
}

void setupDependencies() {
  final List<DiModule> modules = [AppModule(), AuthModule(), ProfileModule()];

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
        BlocProvider<AuthBloc>(create: (context) => getIt<AuthBloc>()),
        BlocProvider<PinBloc>(create: (context) => getIt<PinBloc>()),
        BlocProvider<BiometricSetupBloc>(
          create: (context) => getIt<BiometricSetupBloc>(),
        ),
        BlocProvider<UnlockBloc>(create: (context) => getIt<UnlockBloc>()),
        BlocProvider<ProfileBloc>(
          create: (context) =>
              getIt<ProfileBloc>()..add(const LoadProfile('1')),
        ),
        BlocProvider<KpiBloc>(create: (context) => getIt<KpiBloc>()),
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
