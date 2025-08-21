class AppConfig {
  // Development helper: when true, SplashPage routes directly based on auth only
  // - If authenticated: go to main page
  // - If not authenticated: go to login page
  // When false, the normal flow (including UnlockPage if enabled) is used.
  static const bool devBypassUnlockOnStart = true;
}
