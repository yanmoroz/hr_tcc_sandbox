import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/pin_bloc.dart';
import '../blocs/pin_event.dart';
import '../blocs/pin_state.dart';
import '../widgets/pin_entry.dart';
import '../../../../shared/widgets/app_top_bar.dart';

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
      context.read<PinBloc>().add(StartPinCreation());
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: BlocBuilder<PinBloc, PinState>(
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

              return PinEntry(
                title: 'Создайте код доступа',
                subtitle: 'Войдите в свою учётную запись',
                digitCount: digitCount,
                maxDigits: 4,
                isLoading: isLoading,
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
