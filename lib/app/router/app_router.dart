import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/profile/presentation/pages/profile_kpi_page.dart';

class AppRouter {
  static const String profile = '/';
  static const String profileKpi = '/profile/kpi';

  static GoRouter get router => GoRouter(
    initialLocation: profile,
    routes: [
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
              onPressed: () => context.go(profile),
              child: const Text('Вернуться на главную'),
            ),
          ],
        ),
      ),
    );
  }
}
