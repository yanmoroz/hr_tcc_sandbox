import 'package:equatable/equatable.dart';
import '../../domain/entities/biometric_type.dart';

abstract class UnlockEvent extends Equatable {
  const UnlockEvent();

  @override
  List<Object?> get props => [];
}

class UnlockStarted extends UnlockEvent {}

class UnlockDigitEntered extends UnlockEvent {
  final String digit;
  const UnlockDigitEntered(this.digit);
  @override
  List<Object?> get props => [digit];
}

class UnlockDigitDeleted extends UnlockEvent {
  const UnlockDigitDeleted();
}

class UnlockSubmitPin extends UnlockEvent {}

class UnlockBiometricRequested extends UnlockEvent {}

class UnlockBiometricAvailabilityLoaded extends UnlockEvent {
  final BiometricType biometricType;
  const UnlockBiometricAvailabilityLoaded(this.biometricType);
  @override
  List<Object?> get props => [biometricType];
}

class UnlockResetPinRequested extends UnlockEvent {}
