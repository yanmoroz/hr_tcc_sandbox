import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../blocs/unlock_bloc.dart';
import '../blocs/unlock_event.dart';
import '../blocs/unlock_state.dart';
import '../widgets/pin_entry.dart';
import '../../../../app/router/app_router.dart';

class UnlockPage extends StatefulWidget {
  const UnlockPage({super.key});

  @override
  State<UnlockPage> createState() => _UnlockPageState();
}

class _UnlockPageState extends State<UnlockPage> {
  @override
  void initState() {
    super.initState();
    context.read<UnlockBloc>().add(UnlockStarted());
  }

  void _onDigitPressed(String digit) {
    HapticFeedback.lightImpact();
    context.read<UnlockBloc>().add(UnlockDigitEntered(digit));
  }

  void _onDeletePressed() {
    HapticFeedback.lightImpact();
    context.read<UnlockBloc>().add(const UnlockDigitDeleted());
  }

  void _onPasswordLoginRequested() {
    context.go(AppRouter.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<UnlockBloc, UnlockState>(
          listener: (context, state) {
            if (state.unlocked) {
              context.go(AppRouter.main);
            }
          },
          builder: (context, state) {
            final showError = state.isError;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Введите код доступа',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Войдите в свою учётную запись',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 60),

                  Expanded(
                    child: PinEntry(
                      title: '',
                      subtitle: null,
                      digitCount: state.digitCount,
                      isLoading: state.isLoading,
                      isError: showError,
                      errorText: showError ? state.errorMessage : null,
                      onDigitPressed: _onDigitPressed,
                      onDeletePressed: _onDeletePressed,
                      leftActionText: 'Вход по паролю',
                      onLeftActionPressed: _onPasswordLoginRequested,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
