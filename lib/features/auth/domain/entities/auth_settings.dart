import 'package:equatable/equatable.dart';
import 'biometric_type.dart';

class AuthSettings extends Equatable {
  final bool isBiometricEnabled;
  final BiometricType? biometricType;
  final bool isPinEnabled;
  final DateTime? lastLoginAt;
  final String? lastLoginMethod;

  const AuthSettings({
    this.isBiometricEnabled = false,
    this.biometricType,
    this.isPinEnabled = false,
    this.lastLoginAt,
    this.lastLoginMethod,
  });

  AuthSettings copyWith({
    bool? isBiometricEnabled,
    BiometricType? biometricType,
    bool? isPinEnabled,
    DateTime? lastLoginAt,
    String? lastLoginMethod,
  }) {
    return AuthSettings(
      isBiometricEnabled: isBiometricEnabled ?? this.isBiometricEnabled,
      biometricType: biometricType ?? this.biometricType,
      isPinEnabled: isPinEnabled ?? this.isPinEnabled,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      lastLoginMethod: lastLoginMethod ?? this.lastLoginMethod,
    );
  }

  @override
  List<Object?> get props => [
    isBiometricEnabled,
    biometricType,
    isPinEnabled,
    lastLoginAt,
    lastLoginMethod,
  ];
}
