import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/biometric_type.dart';
import '../../domain/usecases/get_auth_settings.dart';
import '../../domain/usecases/check_biometric_availability.dart';
import '../../domain/usecases/authenticate_with_biometric.dart';
import '../../domain/usecases/validate_pin.dart';
import 'unlock_event.dart';
import 'unlock_state.dart';

class UnlockBloc extends Bloc<UnlockEvent, UnlockState> {
  final GetAuthSettingsUseCase _getAuthSettings;
  final CheckBiometricAvailabilityUseCase _checkBiometricAvailability;
  final AuthenticateWithBiometricUseCase _authenticateWithBiometric;
  final ValidatePinUseCase _validatePin;
  bool _biometricAttempted = false;

  UnlockBloc({
    required GetAuthSettingsUseCase getAuthSettings,
    required CheckBiometricAvailabilityUseCase checkBiometricAvailability,
    required AuthenticateWithBiometricUseCase authenticateWithBiometric,
    required ValidatePinUseCase validatePin,
  }) : _getAuthSettings = getAuthSettings,
       _checkBiometricAvailability = checkBiometricAvailability,
       _authenticateWithBiometric = authenticateWithBiometric,
       _validatePin = validatePin,
       super(const UnlockState()) {
    on<UnlockStarted>(_onStarted);
    on<UnlockDigitEntered>(_onDigitEntered);
    on<UnlockDigitDeleted>(_onDigitDeleted);
    on<UnlockSubmitPin>(_onSubmitPin);
    on<UnlockBiometricRequested>(_onBiometricRequested);
  }

  Future<void> _onStarted(
    UnlockStarted event,
    Emitter<UnlockState> emit,
  ) async {
    // load settings and check biometrics
    final settings = await _getAuthSettings();
    final biometricType = await _checkBiometricAvailability();

    final shouldAutoPrompt =
        settings.isBiometricEnabled &&
        biometricType != BiometricType.none &&
        !_biometricAttempted;

    emit(
      state.copyWith(
        biometricsEnabled: settings.isBiometricEnabled,
        biometricType: biometricType,
      ),
    );

    if (shouldAutoPrompt) add(UnlockBiometricRequested());
  }

  void _onDigitEntered(UnlockDigitEntered event, Emitter<UnlockState> emit) {
    if (state.digitCount < 4) {
      final newPin = state.currentPin + event.digit;
      final newCount = state.digitCount + 1;
      emit(
        state.copyWith(
          currentPin: newPin,
          digitCount: newCount,
          isError: false,
          errorMessage: null,
        ),
      );
      if (newCount == 4) {
        add(UnlockSubmitPin());
      }
    }
  }

  void _onDigitDeleted(UnlockDigitDeleted event, Emitter<UnlockState> emit) {
    if (state.digitCount > 0) {
      final newPin = state.currentPin.substring(0, state.currentPin.length - 1);
      emit(
        state.copyWith(currentPin: newPin, digitCount: state.digitCount - 1),
      );
    }
  }

  Future<void> _onSubmitPin(
    UnlockSubmitPin event,
    Emitter<UnlockState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final isValid = await _validatePin(state.currentPin);
    if (isValid) {
      emit(state.copyWith(isLoading: false, unlocked: true));
      // On success, leave navigation to UI/Router after listening to success
    } else {
      emit(
        state.copyWith(
          isLoading: false,
          isError: true,
          errorMessage: 'Код не подходит, попробуйте снова',
          currentPin: '',
          digitCount: 0,
        ),
      );
    }
  }

  Future<void> _onBiometricRequested(
    UnlockBiometricRequested event,
    Emitter<UnlockState> emit,
  ) async {
    if (_biometricAttempted) return;
    _biometricAttempted = true;
    emit(state.copyWith(isLoading: true));
    final isOk = await _authenticateWithBiometric();
    if (isOk) {
      emit(state.copyWith(isLoading: false, unlocked: true));
    } else {
      emit(state.copyWith(isLoading: false));
    }
  }
}
