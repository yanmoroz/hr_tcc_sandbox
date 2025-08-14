import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.username,
    required super.email,
    required super.fullName,
    super.avatarUrl,
    required super.role,
    required super.createdAt,
    required super.status,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      role: UserRole.values.firstWhere(
        (role) => role.name == json['role'],
        orElse: () => UserRole.employee,
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: UserStatus.values.firstWhere(
        (status) => status.name == json['status'],
        orElse: () => UserStatus.active,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'fullName': fullName,
      'avatarUrl': avatarUrl,
      'role': role.name,
      'createdAt': createdAt.toIso8601String(),
      'status': status.name,
    };
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      username: user.username,
      email: user.email,
      fullName: user.fullName,
      avatarUrl: user.avatarUrl,
      role: user.role,
      createdAt: user.createdAt,
      status: user.status,
    );
  }

  User toEntity() {
    return User(
      id: id,
      username: username,
      email: email,
      fullName: fullName,
      avatarUrl: avatarUrl,
      role: role,
      createdAt: createdAt,
      status: status,
    );
  }
}
