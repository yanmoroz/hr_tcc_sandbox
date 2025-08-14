import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

class UpdateProfile {
  final ProfileRepository repository;

  UpdateProfile(this.repository);

  Future<Profile> call(Profile profile) async {
    return await repository.updateProfile(profile);
  }
}
