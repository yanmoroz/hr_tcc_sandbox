import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/applications/presentation/blocs/application_detail_event.dart';
import '../../features/applications/presentation/pages/applications_page.dart';
import '../../shared/widgets/app_top_bar.dart';
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
import '../../features/news/presentation/pages/news_page.dart';
import '../../features/news/presentation/blocs/news_bloc.dart';
import '../../features/news/presentation/blocs/news_event.dart';
import '../../features/applications/presentation/pages/create_application_page.dart';
import '../../features/applications/presentation/blocs/applications_bloc.dart';
import '../../features/applications/presentation/blocs/applications_event.dart';
import '../../features/applications/presentation/pages/new_application_page.dart';
import '../../features/applications/presentation/blocs/new_application_bloc.dart';
import '../../features/applications/presentation/blocs/new_application_event.dart';
import '../../features/address_book/presentation/pages/address_book_page.dart';
import '../../features/more/presentation/pages/more_page.dart';
import '../../features/address_book/presentation/blocs/address_book_bloc.dart';
// removed unused import
import '../../features/applications/domain/entities/application_type.dart';
import '../../features/applications/presentation/blocs/application_detail_bloc.dart';
import '../../features/applications/presentation/pages/application_detail_page.dart';
import '../../features/applications/presentation/blocs/applications_widget_cubit.dart';

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
  static const String applications = '/applications';
  static const String addressBook = '/address-book';
  static const String more = '/more';
  static const String quickLinks = '/quick-links';
  static const String surveys = '/surveys';
  static const String surveyDetail = '/survey-detail';
  static const String resale = '/resale';
  static const String resaleDetail = '/resale-detail';
  static const String news = '/news';
  static const String createApplication = '/create-application';
  static const String newApplication = '/applications/new/:applicationType';
  static const String applicationDetail = '/applications/:applicationId';

  static ApplicationType _parseApplicationType(String applicationTypeString) {
    try {
      return ApplicationType.values.firstWhere(
        (type) => type.name == applicationTypeString,
        orElse: () => ApplicationType.employmentCertificate,
      );
    } catch (e) {
      return ApplicationType.employmentCertificate;
    }
  }

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
      // Main page with local tabs (no persistent shell)
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
              BlocProvider<AddressBookBloc>(
                create: (context) => getIt<AddressBookBloc>(),
              ),
              BlocProvider<ApplicationsWidgetCubit>(
                create: (context) => getIt<ApplicationsWidgetCubit>(),
              ),
              BlocProvider<NewsBloc>(create: (context) => getIt<NewsBloc>()),
            ],
            child: const MainPage(),
          ),
        ),
      ),
      // Simple routes (forward navigations won't show bottom bar)
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
        path: news,
        name: 'news',
        pageBuilder: (context, state) => SlidePageTransition(
          key: state.pageKey,
          child: BlocProvider<NewsBloc>(
            create: (context) => getIt<NewsBloc>()..add(NewsStarted()),
            child: const NewsPage(),
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
      GoRoute(
        path: applications,
        name: 'applications',
        pageBuilder: (context, state) =>
            SlidePageTransition(key: state.pageKey, child: ApplicationsPage()),
      ),
      GoRoute(
        path: createApplication,
        name: 'createApplication',
        pageBuilder: (context, state) => SlidePageTransition(
          key: state.pageKey,
          child: BlocProvider<ApplicationsBloc>(
            create: (context) =>
                getIt<ApplicationsBloc>()..add(ApplicationsStarted()),
            child: const CreateApplicationPage(),
          ),
        ),
      ),
      GoRoute(
        path: newApplication,
        name: 'newApplication',
        pageBuilder: (context, state) {
          final applicationTypeString =
              state.pathParameters['applicationType'] ?? '';
          final applicationType = _parseApplicationType(applicationTypeString);
          return SlidePageTransition(
            key: state.pageKey,
            child: BlocProvider<NewApplicationBloc>(
              create: (context) =>
                  getIt<NewApplicationBloc>()
                    ..add(NewApplicationStarted(applicationType)),
              child: NewApplicationPage(applicationType: applicationType),
            ),
          );
        },
      ),
      GoRoute(
        path: applicationDetail,
        name: 'applicationDetail',
        pageBuilder: (context, state) {
          final id = state.pathParameters['applicationId'] ?? '';
          return SlidePageTransition(
            key: state.pageKey,
            child: BlocProvider<ApplicationDetailBloc>(
              create: (context) =>
                  getIt<ApplicationDetailBloc>()
                    ..add(ApplicationDetailStarted(id)),
              child: ApplicationDetailPage(applicationId: id),
            ),
          );
        },
      ),
      GoRoute(
        path: addressBook,
        name: 'addressBook',
        pageBuilder: (context, state) =>
            SlidePageTransition(key: state.pageKey, child: AddressBookPage()),
      ),
      GoRoute(
        path: more,
        name: 'more',
        pageBuilder: (context, state) =>
            SlidePageTransition(key: state.pageKey, child: MorePage()),
      ),
    ],
    errorBuilder: (context, state) => _buildErrorPage(context, state),
  );

  static Widget _buildErrorPage(BuildContext context, GoRouterState state) {
    return Scaffold(
      appBar: const AppTopBar(title: 'Ошибка'),
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
