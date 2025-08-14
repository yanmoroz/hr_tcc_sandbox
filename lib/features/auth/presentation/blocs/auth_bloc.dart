import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/usecases/get_auth_settings.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetAuthSettingsUseCase _getAuthSettingsUseCase;

  AuthBloc({
    required LoginUseCase loginUseCase,
    required LogoutUseCase logoutUseCase,
    required GetAuthSettingsUseCase getAuthSettingsUseCase,
  }) : _loginUseCase = loginUseCase,
       _logoutUseCase = logoutUseCase,
       _getAuthSettingsUseCase = getAuthSettingsUseCase,
       super(const AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckAuthenticationStatus>(_onCheckAuthenticationStatus);
    on<ClearAuthError>(_onClearAuthError);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      // Validate data processing agreement
      if (!event.agreeToDataProcessing) {
        emit(
          const LoginError(
            'Необходимо согласие на обработку персональных данных',
          ),
        );
        return;
      }

      // Validate input fields
      if (event.username.isEmpty || event.password.isEmpty) {
        emit(const LoginError('Заполните все поля'));
        return;
      }

      emit(const LoginLoading());

      final user = await _loginUseCase(event.username, event.password);
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(LoginError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading());
      await _logoutUseCase();
      emit(const AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> _onCheckAuthenticationStatus(
    CheckAuthenticationStatus event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading());

      // Check if user has completed initial setup
      final authSettings = await _getAuthSettingsUseCase();

      if (authSettings.isPinEnabled) {
        // User has completed setup, show PIN entry
        emit(const AuthUnauthenticated());
      } else {
        // User needs to complete setup
        emit(const AuthUnauthenticated());
      }
    } catch (e) {
      emit(const AuthUnauthenticated());
    }
  }

  void _onClearAuthError(ClearAuthError event, Emitter<AuthState> emit) {
    if (state is LoginError) {
      emit(const AuthUnauthenticated());
    }
  }
}
