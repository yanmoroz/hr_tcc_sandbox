import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

class UpdateProfileUseCase {
  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<Profile> call(Profile profile) async {
    return await repository.updateProfile(profile);
  }
}
