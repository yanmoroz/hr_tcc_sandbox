import 'package:equatable/equatable.dart';
import '../../domain/entities/biometric_type.dart';

abstract class BiometricSetupEvent extends Equatable {
  const BiometricSetupEvent();

  @override
  List<Object?> get props => [];
}

class BiometricSetupStarted extends BiometricSetupEvent {}

class BiometricEnableRequested extends BiometricSetupEvent {
  final BiometricType biometricType;
  const BiometricEnableRequested(this.biometricType);

  @override
  List<Object?> get props => [biometricType];
}

class BiometricSkipRequested extends BiometricSetupEvent {}
