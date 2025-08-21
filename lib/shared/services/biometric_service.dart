import 'package:local_auth/local_auth.dart' as la;
import '../../features/auth/domain/entities/biometric_type.dart';

abstract class BiometricService {
  Future<BiometricType> checkBiometricAvailability();
  Future<bool> authenticateWithBiometric();
  Future<bool> isBiometricAvailable();
}

class BiometricServiceImpl implements BiometricService {
  final la.LocalAuthentication _auth = la.LocalAuthentication();

  @override
  Future<BiometricType> checkBiometricAvailability() async {
    try {
      final bool canCheck = await _auth.canCheckBiometrics;
      if (!canCheck) return BiometricType.none;

      final List<BiometricType> available = await _mapAvailableBiometrics();
      // Prefer Face ID when present, then Touch ID, else fingerprint, else none
      if (available.contains(BiometricType.faceId)) {
        return BiometricType.faceId;
      }
      if (available.contains(BiometricType.touchId)) {
        return BiometricType.touchId;
      }
      if (available.contains(BiometricType.fingerprint)) {
        return BiometricType.fingerprint;
      }
      return BiometricType.none;
    } catch (_) {
      return BiometricType.none;
    }
  }

  @override
  Future<bool> authenticateWithBiometric() async {
    try {
      final bool didAuthenticate = await _auth.authenticate(
        localizedReason: 'Authenticate to continue',
        options: const la.AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );
      return didAuthenticate;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> isBiometricAvailable() async {
    final biometricType = await checkBiometricAvailability();
    return biometricType != BiometricType.none;
  }

  Future<List<BiometricType>> _mapAvailableBiometrics() async {
    final Set<BiometricType> mapped = {};
    try {
      final List<la.BiometricType> available = await _auth
          .getAvailableBiometrics();
      for (final b in available) {
        switch (b) {
          case la.BiometricType.face:
            mapped.add(BiometricType.faceId);
            break;
          case la.BiometricType.fingerprint:
            mapped.add(BiometricType.fingerprint);
            break;
          case la.BiometricType.strong:
          case la.BiometricType.weak:
          case la.BiometricType.iris:
            mapped.add(BiometricType.fingerprint);
            break;
        }
      }
    } catch (_) {}
    return mapped.toList();
  }
}
