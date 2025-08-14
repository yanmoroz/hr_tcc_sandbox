import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/create_pin_page.dart';
import '../../features/auth/presentation/pages/repeat_pin_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/profile/presentation/pages/profile_kpi_page.dart';

class AppRouter {
  static const String login = '/';
  static const String createPin = '/create-pin';
  static const String repeatPin = '/repeat-pin';
  static const String profile = '/profile';
  static const String profileKpi = '/profile/kpi';

  static GoRouter get router => GoRouter(
    initialLocation: login,
    routes: [
      GoRoute(
        path: login,
        name: 'login',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const LoginPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        path: createPin,
        name: 'createPin',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const CreatePinPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: animation.drive(
                Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero),
              ),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: '$repeatPin/:pin',
        name: 'repeatPin',
        pageBuilder: (context, state) {
          final pin = state.pathParameters['pin'] ?? '1234';
          return CustomTransitionPage(
            key: state.pageKey,
            child: RepeatPinPage(originalPin: pin),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: animation.drive(
                      Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ),
                    ),
                    child: child,
                  );
                },
          );
        },
      ),
      GoRoute(
        path: profile,
        name: 'profile',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ProfilePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: animation.drive(
                Tween<Offset>(begin: const Offset(-1.0, 0.0), end: Offset.zero),
              ),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: profileKpi,
        name: 'profileKpi',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ProfileKpiPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: animation.drive(
                Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero),
              ),
              child: child,
            );
          },
        ),
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
              onPressed: () => context.go(login),
              child: const Text('Вернуться на главную'),
            ),
          ],
        ),
      ),
    );
  }
}
