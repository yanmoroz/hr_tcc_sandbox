import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/create_pin.dart';
import '../../domain/usecases/validate_pin.dart';
import 'pin_event.dart';
import 'pin_state.dart';

class PinBloc extends Bloc<PinEvent, PinState> {
  final CreatePinUseCase _createPinUseCase;

  PinBloc({
    required CreatePinUseCase createPinUseCase,
    required ValidatePinUseCase validatePinUseCase,
  }) : _createPinUseCase = createPinUseCase,
       super(const PinInitial()) {
    on<PinDigitEntered>(_onPinDigitEntered);
    on<PinDigitDeleted>(_onPinDigitDeleted);
    on<PinCreationConfirmed>(_onPinConfirmed);
    on<PinRepeated>(_onPinRepeated);
    on<PinReset>(_onPinReset);
    on<PinValidationFailed>(_onPinValidationFailed);
    on<StartPinCreation>(_onStartPinCreation);
    on<StartPinConfirmation>(_onStartPinConfirmation);
  }

  void _onPinDigitEntered(PinDigitEntered event, Emitter<PinState> emit) {
    if (state is PinCreating) {
      final currentState = state as PinCreating;
      if (currentState.digitCount < 4) {
        final newPin = currentState.currentPin + event.digit;
        final newDigitCount = currentState.digitCount + 1;

        emit(PinCreating(currentPin: newPin, digitCount: newDigitCount));
      }
    } else if (state is PinConfirming) {
      final currentState = state as PinConfirming;
      if (currentState.digitCount < 4) {
        final newPin = currentState.currentPin + event.digit;
        final newDigitCount = currentState.digitCount + 1;

        emit(
          PinConfirming(
            originalPin: currentState.originalPin,
            currentPin: newPin,
            digitCount: newDigitCount,
          ),
        );
      }
    } else {
      // Start creating new PIN
      emit(const PinCreating(currentPin: '', digitCount: 0));
      add(event); // Re-add the event to handle it in the new state
    }
  }

  void _onPinDigitDeleted(PinDigitDeleted event, Emitter<PinState> emit) {
    if (state is PinCreating) {
      final currentState = state as PinCreating;
      if (currentState.digitCount > 0) {
        final newPin = currentState.currentPin.substring(
          0,
          currentState.digitCount - 1,
        );
        final newDigitCount = currentState.digitCount - 1;

        emit(PinCreating(currentPin: newPin, digitCount: newDigitCount));
      }
    } else if (state is PinConfirming) {
      final currentState = state as PinConfirming;
      if (currentState.digitCount > 0) {
        final newPin = currentState.currentPin.substring(
          0,
          currentState.digitCount - 1,
        );
        final newDigitCount = currentState.digitCount - 1;

        emit(
          PinConfirming(
            originalPin: currentState.originalPin,
            currentPin: newPin,
            digitCount: newDigitCount,
          ),
        );
      }
    }
  }

  Future<void> _onPinConfirmed(
    PinCreationConfirmed event,
    Emitter<PinState> emit,
  ) async {
    try {
      emit(const PinCreatingLoading());
      await _createPinUseCase(event.pin);
      emit(PinCreated(event.pin));
    } catch (e) {
      emit(PinError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> _onPinRepeated(PinRepeated event, Emitter<PinState> emit) async {
    if (state is PinConfirming) {
      final currentState = state as PinConfirming;

      if (event.pin == currentState.originalPin) {
        try {
          emit(const PinConfirmingLoading());
          await _createPinUseCase(event.pin);
          emit(const PinConfirmed());
        } catch (e) {
          emit(PinError(e.toString().replaceAll('Exception: ', '')));
        }
      } else {
        emit(const PinMismatch());
      }
    }
  }

  void _onPinReset(PinReset event, Emitter<PinState> emit) {
    emit(const PinInitial());
  }

  void _onPinValidationFailed(
    PinValidationFailed event,
    Emitter<PinState> emit,
  ) {
    emit(const PinMismatch());
  }

  void _onStartPinCreation(StartPinCreation event, Emitter<PinState> emit) {
    emit(const PinCreating(currentPin: '', digitCount: 0));
  }

  void _onStartPinConfirmation(
    StartPinConfirmation event,
    Emitter<PinState> emit,
  ) {
    emit(
      PinConfirming(
        originalPin: event.originalPin,
        currentPin: '',
        digitCount: 0,
      ),
    );
  }
}
