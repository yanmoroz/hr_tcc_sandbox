import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../domain/usecases/is_authenticated.dart';
import '../../domain/usecases/get_auth_settings.dart';
import '../../../../app/router/app_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final GetIt _getIt = GetIt.instance;

  @override
  void initState() {
    super.initState();
    _resolveInitialRoute();
  }

  Future<void> _resolveInitialRoute() async {
    final isAuthenticated = await _getIt<IsAuthenticatedUseCase>()();
    if (!mounted) return;

    if (!isAuthenticated) {
      context.go(AppRouter.login);
      return;
    }

    final settings = await _getIt<GetAuthSettingsUseCase>()();
    if (!mounted) return;

    if (settings.isPinEnabled || (settings.isBiometricEnabled)) {
      context.go(AppRouter.unlock);
    } else {
      context.go(AppRouter.profile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
