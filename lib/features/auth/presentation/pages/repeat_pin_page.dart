import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/pin_bloc.dart';
import '../blocs/pin_event.dart';
import '../blocs/pin_state.dart';
import '../widgets/pin_input.dart';
import '../widgets/numeric_keypad.dart';

class RepeatPinPage extends StatefulWidget {
  final String originalPin;

  const RepeatPinPage({super.key, required this.originalPin});

  @override
  State<RepeatPinPage> createState() => _RepeatPinPageState();
}

class _RepeatPinPageState extends State<RepeatPinPage> {
  @override
  void initState() {
    super.initState();
    // Start PIN confirmation when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PinBloc>().startPinConfirmation(widget.originalPin);
    });
  }

  void _onDigitPressed(String digit) {
    HapticFeedback.lightImpact();
    context.read<PinBloc>().add(PinDigitEntered(digit));
  }

  void _onDeletePressed() {
    HapticFeedback.lightImpact();
    context.read<PinBloc>().add(const PinDigitDeleted());
  }

  void _onBackPressed() {
    context.go('/create-pin');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocListener<PinBloc, PinState>(
          listener: (context, state) {
            if (state is PinConfirmed) {
              // Navigate to biometric setup or main app
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('PIN успешно создан!'),
                  backgroundColor: Colors.green,
                ),
              );
              // TODO: Navigate to biometric setup or main app
            } else if (state is PinMismatch) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Код не совпадает'),
                  backgroundColor: Colors.red,
                ),
              );
              // Reset PIN input after a short delay to show the error animation
              Future.delayed(const Duration(milliseconds: 800), () {
                if (mounted) {
                  context.read<PinBloc>().startPinConfirmation(
                    widget.originalPin,
                  );
                }
              });
            } else if (state is PinError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Column(
            children: [
              // Header with back button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: _onBackPressed,
                      icon: const Icon(Icons.arrow_back, color: Colors.black87),
                    ),
                  ],
                ),
              ),

              // Main content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),

                      // Title
                      const Text(
                        'Повторите ПИН-код',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 8),

                      // Subtitle
                      const Text(
                        'Для быстрого входа в приложение',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 60),

                      // PIN Input
                      BlocBuilder<PinBloc, PinState>(
                        builder: (context, state) {
                          int digitCount = 0;
                          bool isLoading = false;
                          bool isError = false;

                          if (state is PinConfirming) {
                            digitCount = state.digitCount;

                            // Auto-submit when 4 digits are entered
                            if (digitCount == 4) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                context.read<PinBloc>().add(
                                  PinRepeated(state.currentPin),
                                );
                              });
                            }
                          } else if (state is PinConfirmingLoading) {
                            isLoading = true;
                          } else if (state is PinMismatch) {
                            isError = true;
                          }

                          return Column(
                            children: [
                              PinInput(
                                digitCount: digitCount,
                                maxDigits: 4,
                                size: 16,
                                isError: isError,
                              ),

                              if (isLoading) ...[
                                const SizedBox(height: 24),
                                const CircularProgressIndicator(),
                              ],
                            ],
                          );
                        },
                      ),

                      const Spacer(),

                      // Numeric Keypad
                      NumericKeypad(
                        onDigitPressed: _onDigitPressed,
                        onDeletePressed: _onDeletePressed,
                        showDeleteButton: true,
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
