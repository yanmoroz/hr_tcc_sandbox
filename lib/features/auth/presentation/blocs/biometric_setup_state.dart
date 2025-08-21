import 'package:equatable/equatable.dart';
import '../../domain/entities/biometric_type.dart';

abstract class BiometricSetupState extends Equatable {
  const BiometricSetupState();

  @override
  List<Object?> get props => [];
}

class BiometricSetupInitial extends BiometricSetupState {}

class BiometricSetupLoading extends BiometricSetupState {}

class BiometricSetupAvailability extends BiometricSetupState {
  final BiometricType biometricType;
  const BiometricSetupAvailability(this.biometricType);

  @override
  List<Object?> get props => [biometricType];
}

class BiometricSetupCompleted extends BiometricSetupState {}

class BiometricSetupSkipped extends BiometricSetupState {}

class BiometricSetupError extends BiometricSetupState {
  final String message;
  const BiometricSetupError(this.message);

  @override
  List<Object?> get props => [message];
}
