import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/profile_bloc.dart';
import '../blocs/profile_event.dart';
import '../blocs/profile_state.dart';
import '../widgets/profile_header.dart';
import '../widgets/department_position_card.dart';
import '../widgets/kpi_summary_card.dart';
import '../widgets/income_card.dart';
import '../widgets/leave_card.dart';
import '../../../auth/presentation/blocs/auth_bloc.dart';
import '../../../auth/presentation/blocs/auth_event.dart';
import '../../../../app/router/app_router.dart';
import '../../../../shared/widgets/app_top_bar.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppTopBar(
        title: 'Профиль',
        showBackButton: false,
        trailing: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            _showLogoutDialog(context);
          },
        ),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ProfileHeader(profile: state.profile),
                  const SizedBox(height: 24),
                  DepartmentPositionCard(profile: state.profile),
                  const SizedBox(height: 16),
                  KpiSummaryCard(profile: state.profile),
                  const SizedBox(height: 16),
                  IncomeCard(profile: state.profile),
                  const SizedBox(height: 16),
                  LeaveCard(profile: state.profile),
                ],
              ),
            );
          } else if (state is ProfileError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                  const SizedBox(height: 16),
                  Text(
                    'Ошибка загрузки профиля',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ProfileBloc>().add(const LoadProfile('1'));
                    },
                    child: const Text('Повторить'),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    if (Platform.isIOS) {
      // iOS - Use CupertinoAlertDialog
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('Хотите выйти?'),
            content: const Text(
              'Для повторной авторизации необходимо будет ввести логин и пароль',
            ),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Отменить'),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                  _performLogout(context);
                },
                isDestructiveAction: true,
                child: const Text('Выйти'),
              ),
            ],
          );
        },
      );
    } else {
      // Android and other platforms - Use Material AlertDialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Хотите выйти?'),
            content: const Text(
              'Для повторной авторизации необходимо будет ввести логин и пароль',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Отменить'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _performLogout(context);
                },
                style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.all(Colors.red),
                ),
                child: const Text('Выйти'),
              ),
            ],
          );
        },
      );
    }
  }

  void _performLogout(BuildContext context) {
    context.read<AuthBloc>().add(LogoutRequested());
    context.go(AppRouter.login);
  }
}
