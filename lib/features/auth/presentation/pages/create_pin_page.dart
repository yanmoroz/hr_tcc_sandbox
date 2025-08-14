import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/pin_bloc.dart';
import '../blocs/pin_event.dart';
import '../blocs/pin_state.dart';
import '../widgets/pin_input.dart';
import '../widgets/numeric_keypad.dart';

class CreatePinPage extends StatefulWidget {
  const CreatePinPage({super.key});

  @override
  State<CreatePinPage> createState() => _CreatePinPageState();
}

class _CreatePinPageState extends State<CreatePinPage> {
  @override
  void initState() {
    super.initState();
    // Start PIN creation when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PinBloc>().startPinCreation();
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
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocListener<PinBloc, PinState>(
          listener: (context, state) {
            if (state is PinCreated) {
              // Navigate to repeat PIN page with the created PIN
              context.push('/repeat-pin/${state.pin}');
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
                        'Создайте код доступа',
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
                        'Войдите в свою учётную запись',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 60),

                      // PIN Input
                      BlocBuilder<PinBloc, PinState>(
                        builder: (context, state) {
                          int digitCount = 0;
                          bool isLoading = false;

                          if (state is PinCreating) {
                            digitCount = state.digitCount;

                            // Auto-submit when 4 digits are entered
                            if (digitCount == 4) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                context.read<PinBloc>().add(
                                  PinCreationConfirmed(state.currentPin),
                                );
                              });
                            }
                          } else if (state is PinCreatingLoading) {
                            isLoading = true;
                          }

                          return Column(
                            children: [
                              PinInput(
                                digitCount: digitCount,
                                maxDigits: 4,
                                size: 16,
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
