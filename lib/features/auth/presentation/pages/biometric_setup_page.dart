import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../gen/assets.gen.dart';
import '../../domain/entities/biometric_type.dart';
import '../blocs/biometric_setup_bloc.dart';
import '../blocs/biometric_setup_event.dart';
import '../blocs/biometric_setup_state.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../app/router/app_router.dart';
import '../widgets/app_button.dart';

class BiometricSetupPage extends StatefulWidget {
  const BiometricSetupPage({super.key});

  @override
  State<BiometricSetupPage> createState() => _BiometricSetupPageState();
}

class _BiometricSetupPageState extends State<BiometricSetupPage> {
  @override
  void initState() {
    super.initState();
    context.read<BiometricSetupBloc>().add(BiometricSetupStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SafeArea(
        child: BlocConsumer<BiometricSetupBloc, BiometricSetupState>(
          listener: (context, state) {
            if (state is BiometricSetupCompleted ||
                state is BiometricSetupSkipped) {
              context.go(AppRouter.main);
            }
          },
          builder: (context, state) {
            if (state is BiometricSetupLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is BiometricSetupAvailability) {
              final title = state.biometricType == BiometricType.faceId
                  ? 'Хотите использовать Face ID\nдля входа в приложение?'
                  : 'Использовать биометрию\nдля входа в приложение?';
              final primaryLabel = state.biometricType == BiometricType.faceId
                  ? 'Использовать Face ID'
                  : 'Использовать биометрию';

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 48),
                    // Icon area: Face ID specific or generic fingerprint
                    Center(
                      child: state.biometricType == BiometricType.faceId
                          ? SvgPicture.asset(
                              Assets.icons.auth.faceIdBig,
                              width: 120,
                              height: 120,
                            )
                          : SvgPicture.asset(
                              Assets.icons.auth.touchIdBig,
                              width: 120,
                              height: 120,
                            ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                        height: 1.25,
                      ),
                    ),
                    const Spacer(),
                    AppButton(
                      text: primaryLabel,
                      backgroundColor: AppTheme.primaryColor,
                      textColor: Colors.white,
                      borderRadius: 12,
                      onPressed: () {
                        context.read<BiometricSetupBloc>().add(
                          BiometricEnableRequested(state.biometricType),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    AppButton(
                      text: 'Входить только с кодом',
                      outlined: true,
                      textColor: Colors.black,
                      borderColor: const Color(0xBABABE9F),
                      borderRadius: 12,
                      onPressed: () {
                        context.read<BiometricSetupBloc>().add(
                          BiometricSkipRequested(),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              );
            }

            if (state is BiometricSetupError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      Text(state.message, textAlign: TextAlign.center),
                      const SizedBox(height: 16),
                      OutlinedButton(
                        onPressed: () => context.read<BiometricSetupBloc>().add(
                          BiometricSetupStarted(),
                        ),
                        child: const Text('Повторить'),
                      ),
                    ],
                  ),
                ),
              );
            }

            // Initial / skipped
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
