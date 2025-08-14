class AuthConstants {
  // API Endpoints
  static const String baseUrl = 'https://api.hr-app.com';
  static const String loginEndpoint = '/auth/login';
  static const String logoutEndpoint = '/auth/logout';
  static const String refreshTokenEndpoint = '/auth/refresh';

  // Storage Keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userKey = 'user';
  static const String pinKey = 'pin';
  static const String authSettingsKey = 'auth_settings';
  static const String isAuthenticatedKey = 'is_authenticated';

  // PIN Validation
  static const int pinLength = 4;
  static const String pinRegex = r'^\d{4}$';

  // Error Messages
  static const String invalidCredentials = 'Неверный логин или пароль';
  static const String networkError = 'Проблемы с интернетом';
  static const String pinMismatch = 'Код не совпадает';
  static const String invalidPin = 'Код не подходит, попробуйте снова';
  static const String biometricNotAvailable = 'Биометрия недоступна';
  static const String biometricAuthenticationFailed =
      'Биометрическая аутентификация не удалась';
}
