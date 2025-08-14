import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_datasource.dart';
import '../models/profile_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<Profile> getProfile(String userId) async {
    try {
      final profileModel = await remoteDataSource.getProfile(userId);
      return profileModel;
    } catch (e) {
      throw Exception('Failed to load profile: $e');
    }
  }

  @override
  Future<Profile> updateProfile(Profile profile) async {
    try {
      final profileModel = await remoteDataSource.updateProfile(
        ProfileModel.fromEntity(profile),
      );
      return profileModel;
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  @override
  Future<void> updateAvatar(String userId, String avatarUrl) async {
    try {
      await remoteDataSource.updateAvatar(userId, avatarUrl);
    } catch (e) {
      throw Exception('Failed to update avatar: $e');
    }
  }
}
