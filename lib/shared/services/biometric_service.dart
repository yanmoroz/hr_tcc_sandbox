import '../../features/auth/domain/entities/biometric_type.dart';

abstract class BiometricService {
  Future<BiometricType> checkBiometricAvailability();
  Future<bool> authenticateWithBiometric();
  Future<bool> isBiometricAvailable();
}

class BiometricServiceImpl implements BiometricService {
  @override
  Future<BiometricType> checkBiometricAvailability() async {
    // Simulate biometric availability check
    await Future.delayed(const Duration(milliseconds: 300));

    // Mock implementation - in real app, this would check device capabilities
    // For now, return Face ID as available
    return BiometricType.faceId;
  }

  @override
  Future<bool> authenticateWithBiometric() async {
    // Simulate biometric authentication
    await Future.delayed(const Duration(milliseconds: 800));

    // Mock implementation - in real app, this would trigger biometric prompt
    // For now, return true (successful authentication)
    return true;
  }

  @override
  Future<bool> isBiometricAvailable() async {
    final biometricType = await checkBiometricAvailability();
    return biometricType != BiometricType.none;
  }
}
