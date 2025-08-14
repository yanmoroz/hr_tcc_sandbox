import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthEvent {
  final String username;
  final String password;
  final bool agreeToDataProcessing;

  const LoginRequested({
    required this.username,
    required this.password,
    required this.agreeToDataProcessing,
  });

  @override
  List<Object?> get props => [username, password, agreeToDataProcessing];
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}

class CheckAuthenticationStatus extends AuthEvent {
  const CheckAuthenticationStatus();
}

class ClearAuthError extends AuthEvent {
  const ClearAuthError();
}
