enum BiometricType { faceId, touchId, fingerprint, none }

extension BiometricTypeExtension on BiometricType {
  String get displayName {
    switch (this) {
      case BiometricType.faceId:
        return 'Face ID';
      case BiometricType.touchId:
        return 'Touch ID';
      case BiometricType.fingerprint:
        return 'Fingerprint';
      case BiometricType.none:
        return 'None';
    }
  }

  String get description {
    switch (this) {
      case BiometricType.faceId:
        return 'Use Face ID for quick app entry';
      case BiometricType.touchId:
        return 'Use Touch ID for quick app entry';
      case BiometricType.fingerprint:
        return 'Use fingerprint for quick app entry';
      case BiometricType.none:
        return 'Enter only with code';
    }
  }
}
