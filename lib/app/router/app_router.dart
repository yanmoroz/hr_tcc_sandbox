import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/create_pin_page.dart';
import '../../features/auth/presentation/pages/repeat_pin_page.dart';
import '../../features/auth/presentation/pages/biometric_setup_page.dart';
import '../../features/auth/presentation/pages/unlock_page.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/profile/presentation/pages/profile_kpi_page.dart';
import '../../app/presentation/pages/main_page.dart';
import '../../features/quick_links/presentation/pages/quick_links_page.dart';
import '../../features/surveys/presentation/pages/surveys_page.dart';
import '../../features/surveys/presentation/pages/survey_detail_page.dart';
import '../../main.dart';
import '../../features/auth/presentation/blocs/auth_bloc.dart';
import '../../features/auth/presentation/blocs/pin_bloc.dart';
import '../../features/auth/presentation/blocs/biometric_setup_bloc.dart';
import '../../features/auth/presentation/blocs/unlock_bloc.dart';
import '../../features/profile/presentation/blocs/kpi_bloc.dart';
import '../../features/quick_links/presentation/blocs/quick_links_bloc.dart';
import '../../features/surveys/presentation/blocs/surveys_bloc.dart';
import '../../features/surveys/presentation/blocs/survey_detail_bloc.dart';
import '../../features/resale/presentation/blocs/resale_bloc.dart';
import '../../features/resale/presentation/pages/resale_list_page.dart';
import '../../features/resale/presentation/pages/resale_detail_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/requests/presentation/pages/requests_page.dart';
import '../../features/address_book/presentation/pages/address_book_page.dart';
import '../../features/more/presentation/pages/more_page.dart';

// Custom page transition that handles direction automatically
class SlidePageTransition extends CustomTransitionPage {
  SlidePageTransition({required super.key, required super.child})
    : super(
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(
              Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero),
            ),
            child: child,
          );
        },
      );
}

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String unlock = '/unlock';
  static const String createPin = '/create-pin';
  static const String repeatPin = '/repeat-pin';
  static const String biometricSetup = '/biometric-setup';
  static const String profile = '/profile';
  static const String profileKpi = '/profile/kpi';
  static const String main = '/home';
  static const String requests = '/requests';
  static const String addressBook = '/address-book';
  static const String more = '/more';
  static const String quickLinks = '/quick-links';
  static const String surveys = '/surveys';
  static const String surveyDetail = '/survey-detail';
  static const String resale = '/resale';
  static const String resaleDetail = '/resale-detail';

  static GoRouter get router => GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        name: 'splash',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: BlocProvider<AuthBloc>(
            create: (context) => getIt<AuthBloc>(),
            child: const SplashPage(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        path: login,
        name: 'login',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: BlocProvider<AuthBloc>(
            create: (context) => getIt<AuthBloc>(),
            child: const LoginPage(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        path: createPin,
        name: 'createPin',
        pageBuilder: (context, state) => SlidePageTransition(
          key: state.pageKey,
          child: BlocProvider<PinBloc>(
            create: (context) => getIt<PinBloc>(),
            child: const CreatePinPage(),
          ),
        ),
      ),
      GoRoute(
        path: unlock,
        name: 'unlock',
        pageBuilder: (context, state) => SlidePageTransition(
          key: state.pageKey,
          child: BlocProvider<UnlockBloc>(
            create: (context) => getIt<UnlockBloc>(),
            child: const UnlockPage(),
          ),
        ),
      ),
      GoRoute(
        path: '$repeatPin/:pin',
        name: 'repeatPin',
        pageBuilder: (context, state) {
          final pin = state.pathParameters['pin'] ?? '1234';
          return SlidePageTransition(
            key: state.pageKey,
            child: BlocProvider<PinBloc>(
              create: (context) => getIt<PinBloc>(),
              child: RepeatPinPage(originalPin: pin),
            ),
          );
        },
      ),
      GoRoute(
        path: biometricSetup,
        name: 'biometricSetup',
        pageBuilder: (context, state) => SlidePageTransition(
          key: state.pageKey,
          child: BlocProvider<BiometricSetupBloc>(
            create: (context) => getIt<BiometricSetupBloc>(),
            child: const BiometricSetupPage(),
          ),
        ),
      ),
      GoRoute(
        path: profile,
        name: 'profile',
        pageBuilder: (context, state) => SlidePageTransition(
          key: state.pageKey,
          child: MultiBlocProvider(
            providers: [
              BlocProvider<AuthBloc>(create: (context) => getIt<AuthBloc>()),
            ],
            child: const ProfilePage(),
          ),
        ),
      ),
      GoRoute(
        path: profileKpi,
        name: 'profileKpi',
        pageBuilder: (context, state) => SlidePageTransition(
          key: state.pageKey,
          child: BlocProvider<KpiBloc>(
            create: (context) => getIt<KpiBloc>(),
            child: const ProfileKpiPage(),
          ),
        ),
      ),
      // Shell with persistent bottom navigation bar
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainPage(navigationShell: navigationShell),
        branches: [
          // Home branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: main,
                name: 'main',
                pageBuilder: (context, state) => SlidePageTransition(
                  key: state.pageKey,
                  child: MultiBlocProvider(
                    providers: [
                      BlocProvider<QuickLinksBloc>(
                        create: (context) => getIt<QuickLinksBloc>(),
                      ),
                      BlocProvider<SurveysBloc>(
                        create: (context) => getIt<SurveysBloc>(),
                      ),
                      BlocProvider<ResaleBloc>(
                        create: (context) => getIt<ResaleBloc>(),
                      ),
                    ],
                    child: HomePage(),
                  ),
                ),
              ),
              GoRoute(
                path: quickLinks,
                name: 'quickLinks',
                pageBuilder: (context, state) => SlidePageTransition(
                  key: state.pageKey,
                  child: BlocProvider<QuickLinksBloc>(
                    create: (context) => getIt<QuickLinksBloc>(),
                    child: const QuickLinksPage(),
                  ),
                ),
              ),
              GoRoute(
                path: surveys,
                name: 'surveys',
                pageBuilder: (context, state) => SlidePageTransition(
                  key: state.pageKey,
                  child: BlocProvider<SurveysBloc>(
                    create: (context) => getIt<SurveysBloc>(),
                    child: const SurveysPage(),
                  ),
                ),
              ),
              GoRoute(
                path: '$surveyDetail/:surveyId',
                name: 'surveyDetail',
                pageBuilder: (context, state) {
                  final surveyId = state.pathParameters['surveyId'] ?? '';
                  return SlidePageTransition(
                    key: state.pageKey,
                    child: BlocProvider<SurveyDetailBloc>(
                      create: (context) => getIt<SurveyDetailBloc>(),
                      child: SurveyDetailPage(surveyId: surveyId),
                    ),
                  );
                },
              ),
              GoRoute(
                path: resale,
                name: 'resale',
                pageBuilder: (context, state) => SlidePageTransition(
                  key: state.pageKey,
                  child: BlocProvider<ResaleBloc>(
                    create: (context) => getIt<ResaleBloc>(),
                    child: const ResaleListPage(),
                  ),
                ),
              ),
              GoRoute(
                path: '$resaleDetail/:itemId',
                name: 'resaleDetail',
                pageBuilder: (context, state) {
                  final itemId = state.pathParameters['itemId'] ?? '';
                  return SlidePageTransition(
                    key: state.pageKey,
                    child: BlocProvider<ResaleBloc>(
                      create: (context) => getIt<ResaleBloc>(),
                      child: ResaleDetailPage(itemId: itemId),
                    ),
                  );
                },
              ),
            ],
          ),

          // Requests branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: requests,
                name: 'requests',
                pageBuilder: (context, state) => SlidePageTransition(
                  key: state.pageKey,
                  child: RequestsPage(),
                ),
              ),
            ],
          ),

          // Address book branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: addressBook,
                name: 'addressBook',
                pageBuilder: (context, state) => SlidePageTransition(
                  key: state.pageKey,
                  child: AddressBookPage(),
                ),
              ),
            ],
          ),

          // More branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: more,
                name: 'more',
                pageBuilder: (context, state) =>
                    SlidePageTransition(key: state.pageKey, child: MorePage()),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => _buildErrorPage(context, state),
  );

  static Widget _buildErrorPage(BuildContext context, GoRouterState state) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ошибка'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
            const SizedBox(height: 16),
            Text(
              'Страница не найдена',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Путь: ${state.uri.path}',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.push(login),
              child: const Text('Вернуться на главную'),
            ),
          ],
        ),
      ),
    );
  }
}
