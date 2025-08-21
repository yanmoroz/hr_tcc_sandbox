import 'package:equatable/equatable.dart';
import '../../domain/entities/biometric_type.dart';

class UnlockState extends Equatable {
  final int digitCount;
  final String currentPin;
  final bool isLoading;
  final bool isError;
  final String? errorMessage;
  final BiometricType biometricType;
  final bool biometricsEnabled;
  final bool unlocked;

  const UnlockState({
    this.digitCount = 0,
    this.currentPin = '',
    this.isLoading = false,
    this.isError = false,
    this.errorMessage,
    this.biometricType = BiometricType.none,
    this.biometricsEnabled = false,
    this.unlocked = false,
  });

  UnlockState copyWith({
    int? digitCount,
    String? currentPin,
    bool? isLoading,
    bool? isError,
    String? errorMessage,
    BiometricType? biometricType,
    bool? biometricsEnabled,
    bool? unlocked,
  }) {
    return UnlockState(
      digitCount: digitCount ?? this.digitCount,
      currentPin: currentPin ?? this.currentPin,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      errorMessage: errorMessage,
      biometricType: biometricType ?? this.biometricType,
      biometricsEnabled: biometricsEnabled ?? this.biometricsEnabled,
      unlocked: unlocked ?? this.unlocked,
    );
  }

  @override
  List<Object?> get props => [
    digitCount,
    currentPin,
    isLoading,
    isError,
    errorMessage,
    biometricType,
    biometricsEnabled,
    unlocked,
  ];
}
