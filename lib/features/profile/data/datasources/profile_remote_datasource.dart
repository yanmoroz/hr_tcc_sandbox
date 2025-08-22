import '../models/profile_model.dart';
import '../../domain/entities/profile.dart';
import '../../../../shared/services/logger_service.dart';
import '../../../../main.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile(String userId);
  Future<ProfileModel> updateProfile(ProfileModel profile);
  Future<void> updateAvatar(String userId, String avatarUrl);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  @override
  Future<ProfileModel> getProfile(String userId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Mock data matching the design
    return ProfileModel(
      id: '1',
      fullName: 'Гребенников Владимир Александрович',
      email: 'vladimir.grebennikov@tccenter.ru',
      phone: '+7 985 999-00-00',
      workPhone: '+7 985 999-00-00',
      workExtension: '1234',
      position: 'Руководитель проектного офиса',
      department: 'Управление развития',
      hireDate: DateTime(2023, 1, 15),
      avatarUrl: 'https://via.placeholder.com/150',
      employeeId: 'EMP001',
      status: ProfileStatus.active,
      totalIncome: 1234666.0,
      salary: 234666.0,
      bonus: 117333.0,
      remainingLeaveDays: 13,
      kpiProgress: 75.0,
    );
  }

  @override
  Future<ProfileModel> updateProfile(ProfileModel profile) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1000));

    // Return updated profile
    return profile;
  }

  @override
  Future<void> updateAvatar(String userId, String avatarUrl) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock implementation
    getIt<LoggerService>().info('Avatar updated for user $userId: $avatarUrl');
  }
}
