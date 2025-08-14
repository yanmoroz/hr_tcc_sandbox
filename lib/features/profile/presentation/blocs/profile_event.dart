import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadProfile extends ProfileEvent {
  final String userId;

  const LoadProfile(this.userId);

  @override
  List<Object?> get props => [userId];
}

class UpdateProfile extends ProfileEvent {
  final String userId;
  final String fullName;
  final String email;
  final String phone;

  const UpdateProfile({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.phone,
  });

  @override
  List<Object?> get props => [userId, fullName, email, phone];
}

class UpdateAvatar extends ProfileEvent {
  final String userId;
  final String avatarUrl;

  const UpdateAvatar({required this.userId, required this.avatarUrl});

  @override
  List<Object?> get props => [userId, avatarUrl];
}
