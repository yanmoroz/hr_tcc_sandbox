import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/biometric_type.dart';
import '../../domain/usecases/check_biometric_availability.dart';
import '../../domain/usecases/enable_biometric_auth.dart';
import '../../domain/usecases/disable_biometric_auth.dart';
import 'biometric_setup_event.dart';
import 'biometric_setup_state.dart';

class BiometricSetupBloc
    extends Bloc<BiometricSetupEvent, BiometricSetupState> {
  final CheckBiometricAvailabilityUseCase _checkAvailability;
  final EnableBiometricAuthUseCase _enableBiometric;
  final DisableBiometricAuthUseCase _disableBiometric;

  BiometricSetupBloc({
    required CheckBiometricAvailabilityUseCase checkAvailability,
    required EnableBiometricAuthUseCase enableBiometric,
    required DisableBiometricAuthUseCase disableBiometric,
  }) : _checkAvailability = checkAvailability,
       _enableBiometric = enableBiometric,
       _disableBiometric = disableBiometric,
       super(BiometricSetupInitial()) {
    on<BiometricSetupStarted>(_onStarted);
    on<BiometricEnableRequested>(_onEnableRequested);
    on<BiometricSkipRequested>(_onSkipRequested);
  }

  Future<void> _onStarted(
    BiometricSetupStarted event,
    Emitter<BiometricSetupState> emit,
  ) async {
    emit(BiometricSetupLoading());
    try {
      final type = await _checkAvailability();
      if (type == BiometricType.none) {
        emit(BiometricSetupSkipped());
      } else {
        emit(BiometricSetupAvailability(type));
      }
    } catch (e) {
      emit(BiometricSetupError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> _onEnableRequested(
    BiometricEnableRequested event,
    Emitter<BiometricSetupState> emit,
  ) async {
    emit(BiometricSetupLoading());
    try {
      final ok = await _enableBiometric(event.biometricType);
      if (ok) {
        emit(BiometricSetupCompleted());
      } else {
        emit(const BiometricSetupError('Не удалось включить биометрию'));
      }
    } catch (e) {
      emit(BiometricSetupError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> _onSkipRequested(
    BiometricSkipRequested event,
    Emitter<BiometricSetupState> emit,
  ) async {
    emit(BiometricSetupLoading());
    try {
      await _disableBiometric();
      emit(BiometricSetupSkipped());
    } catch (e) {
      emit(BiometricSetupError(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
