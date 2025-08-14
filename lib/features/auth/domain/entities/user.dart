import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String email;
  final String fullName;
  final String? avatarUrl;
  final UserRole role;
  final DateTime createdAt;
  final UserStatus status;

  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.fullName,
    this.avatarUrl,
    required this.role,
    required this.createdAt,
    required this.status,
  });

  @override
  List<Object?> get props => [
    id,
    username,
    email,
    fullName,
    avatarUrl,
    role,
    createdAt,
    status,
  ];
}

enum UserRole { employee, manager, admin, hr }

enum UserStatus { active, inactive, suspended }
