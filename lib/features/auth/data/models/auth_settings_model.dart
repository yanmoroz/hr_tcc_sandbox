import '../../domain/entities/auth_settings.dart';
import '../../domain/entities/biometric_type.dart';

class AuthSettingsModel extends AuthSettings {
  const AuthSettingsModel({
    super.isBiometricEnabled,
    super.biometricType,
    super.isPinEnabled,
    super.lastLoginAt,
    super.lastLoginMethod,
  });

  factory AuthSettingsModel.fromJson(Map<String, dynamic> json) {
    return AuthSettingsModel(
      isBiometricEnabled: json['isBiometricEnabled'] as bool? ?? false,
      biometricType: json['biometricType'] != null
          ? BiometricType.values.firstWhere(
              (type) => type.name == json['biometricType'],
              orElse: () => BiometricType.none,
            )
          : null,
      isPinEnabled: json['isPinEnabled'] as bool? ?? false,
      lastLoginAt: json['lastLoginAt'] != null
          ? DateTime.parse(json['lastLoginAt'] as String)
          : null,
      lastLoginMethod: json['lastLoginMethod'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isBiometricEnabled': isBiometricEnabled,
      'biometricType': biometricType?.name,
      'isPinEnabled': isPinEnabled,
      'lastLoginAt': lastLoginAt?.toIso8601String(),
      'lastLoginMethod': lastLoginMethod,
    };
  }

  factory AuthSettingsModel.fromEntity(AuthSettings settings) {
    return AuthSettingsModel(
      isBiometricEnabled: settings.isBiometricEnabled,
      biometricType: settings.biometricType,
      isPinEnabled: settings.isPinEnabled,
      lastLoginAt: settings.lastLoginAt,
      lastLoginMethod: settings.lastLoginMethod,
    );
  }

  AuthSettings toEntity() {
    return AuthSettings(
      isBiometricEnabled: isBiometricEnabled,
      biometricType: biometricType,
      isPinEnabled: isPinEnabled,
      lastLoginAt: lastLoginAt,
      lastLoginMethod: lastLoginMethod,
    );
  }

  @override
  AuthSettingsModel copyWith({
    bool? isBiometricEnabled,
    BiometricType? biometricType,
    bool? isPinEnabled,
    DateTime? lastLoginAt,
    String? lastLoginMethod,
  }) {
    return AuthSettingsModel(
      isBiometricEnabled: isBiometricEnabled ?? this.isBiometricEnabled,
      biometricType: biometricType ?? this.biometricType,
      isPinEnabled: isPinEnabled ?? this.isPinEnabled,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      lastLoginMethod: lastLoginMethod ?? this.lastLoginMethod,
    );
  }
}
