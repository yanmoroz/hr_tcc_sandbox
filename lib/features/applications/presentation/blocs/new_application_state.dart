import '../../domain/entities/application_purpose.dart';
import '../../domain/entities/application_type.dart';

class NewApplicationState {
  final bool isLoading;
  final ApplicationType applicationType;
  final bool isSubmitting;
  final String? createdId;
  final String? error;
  final List<ApplicationPurpose> purposes;

  const NewApplicationState({
    this.isLoading = false,
    required this.applicationType,
    this.isSubmitting = false,
    this.createdId,
    this.error,
    this.purposes = const [],
  });

  bool get canSubmit {
    return !isSubmitting;
  }

  NewApplicationState copyWith({
    bool? isLoading,
    ApplicationType? applicationType,
    bool? isSubmitting,
    String? createdId,
    String? error,
    List<ApplicationPurpose>? purposes,
  }) {
    return NewApplicationState(
      isLoading: isLoading ?? this.isLoading,
      applicationType: applicationType ?? this.applicationType,
      purposes: purposes ?? this.purposes,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      createdId: createdId ?? this.createdId,
      error: error,
    );
  }
}
