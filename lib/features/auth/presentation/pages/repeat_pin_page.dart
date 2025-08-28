import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/pin_bloc.dart';
import '../blocs/pin_event.dart';
import '../blocs/pin_state.dart';
import '../widgets/pin_entry.dart';
import '../../../../shared/widgets/app_top_bar.dart';

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
      context.read<PinBloc>().add(StartPinConfirmation(widget.originalPin));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppTopBar(),
      body: BlocListener<PinBloc, PinState>(
        listener: (context, state) {
          if (state is PinConfirmed) {
            // Navigate to biometric setup page
            context.push('/biometric-setup');
          } else if (state is PinError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: BlocBuilder<PinBloc, PinState>(
            builder: (context, state) {
              int digitCount = 0;
              bool isLoading = false;
              bool isError = false;

              if (state is PinConfirming) {
                digitCount = state.digitCount;

                // Auto-submit when 4 digits are entered
                if (digitCount == 4) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context.read<PinBloc>().add(PinRepeated(state.currentPin));
                  });
                }
              } else if (state is PinConfirmingLoading) {
                isLoading = true;
              } else if (state is PinMismatch) {
                isError = true;
                digitCount = 4; // Show all dots filled with red

                // Reset after showing error for a moment
                final pinBloc = context.read<PinBloc>();
                Future.delayed(const Duration(milliseconds: 2000), () {
                  if (mounted) {
                    pinBloc.add(StartPinConfirmation(widget.originalPin));
                  }
                });
              }

              return PinEntry(
                title: 'Повторите ПИН-код',
                subtitle: 'Для быстрого входа в приложение',
                digitCount: digitCount,
                maxDigits: 4,
                isLoading: isLoading,
                isError: isError,
                errorText: isError ? 'Код не совпадает' : null,
                onDigitPressed: _onDigitPressed,
                onDeletePressed: _onDeletePressed,
                showDeleteButton: true,
              );
            },
          ),
        ),
      ),
    );
  }
}
