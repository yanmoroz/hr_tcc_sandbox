import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/profile.dart';
import '../../domain/usecases/get_profile.dart';
import '../../domain/usecases/update_profile.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfile;
  final UpdateProfileUseCase updateProfile;

  ProfileBloc({required this.getProfile, required this.updateProfile})
    : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfile>(_onUpdateProfile);
    on<UpdateAvatar>(_onUpdateAvatar);
  }

  Future<void> _onLoadProfile(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      final profile = await getProfile.call(event.userId);
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onUpdateProfile(
    UpdateProfile event,
    Emitter<ProfileState> emit,
  ) async {
    final currentState = state;
    if (currentState is ProfileLoaded) {
      emit(ProfileUpdating(currentState.profile));
      try {
        final updatedProfile = Profile(
          id: currentState.profile.id,
          fullName: event.fullName,
          email: event.email,
          phone: event.phone,
          workPhone: currentState.profile.workPhone,
          workExtension: currentState.profile.workExtension,
          position: currentState.profile.position,
          department: currentState.profile.department,
          hireDate: currentState.profile.hireDate,
          avatarUrl: currentState.profile.avatarUrl,
          employeeId: currentState.profile.employeeId,
          status: currentState.profile.status,
          totalIncome: currentState.profile.totalIncome,
          salary: currentState.profile.salary,
          bonus: currentState.profile.bonus,
          remainingLeaveDays: currentState.profile.remainingLeaveDays,
          kpiProgress: currentState.profile.kpiProgress,
        );
        final result = await updateProfile(updatedProfile);
        emit(ProfileUpdated(result));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    }
  }

  Future<void> _onUpdateAvatar(
    UpdateAvatar event,
    Emitter<ProfileState> emit,
  ) async {
    final currentState = state;
    if (currentState is ProfileLoaded) {
      emit(ProfileUpdating(currentState.profile));
      try {
        final updatedProfile = Profile(
          id: currentState.profile.id,
          fullName: currentState.profile.fullName,
          email: currentState.profile.email,
          phone: currentState.profile.phone,
          workPhone: currentState.profile.workPhone,
          workExtension: currentState.profile.workExtension,
          position: currentState.profile.position,
          department: currentState.profile.department,
          hireDate: currentState.profile.hireDate,
          avatarUrl: event.avatarUrl,
          employeeId: currentState.profile.employeeId,
          status: currentState.profile.status,
          totalIncome: currentState.profile.totalIncome,
          salary: currentState.profile.salary,
          bonus: currentState.profile.bonus,
          remainingLeaveDays: currentState.profile.remainingLeaveDays,
          kpiProgress: currentState.profile.kpiProgress,
        );
        final result = await updateProfile(updatedProfile);
        emit(ProfileUpdated(result));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    }
  }
}
