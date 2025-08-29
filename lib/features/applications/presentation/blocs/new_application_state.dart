import '../../domain/entities/application_purpose.dart';

class NewApplicationState {
  final bool isLoading;
  final String templateId;
  final List<ApplicationPurpose> purposes;
  final String? selectedPurposeId;
  final DateTime? receiveDate;
  final int copies;
  final bool isSubmitting;
  final String? createdId;
  final String? error;

  const NewApplicationState({
    this.isLoading = false,
    this.templateId = '',
    this.purposes = const [],
    this.selectedPurposeId,
    this.receiveDate,
    this.copies = 1,
    this.isSubmitting = false,
    this.createdId,
    this.error,
  });

  bool get canSubmit =>
      selectedPurposeId != null &&
      receiveDate != null &&
      copies > 0 &&
      !isSubmitting;

  NewApplicationState copyWith({
    bool? isLoading,
    String? templateId,
    List<ApplicationPurpose>? purposes,
    String? selectedPurposeId,
    bool clearSelectedPurpose = false,
    DateTime? receiveDate,
    bool clearDate = false,
    int? copies,
    bool? isSubmitting,
    String? createdId,
    String? error,
  }) {
    return NewApplicationState(
      isLoading: isLoading ?? this.isLoading,
      templateId: templateId ?? this.templateId,
      purposes: purposes ?? this.purposes,
      selectedPurposeId: clearSelectedPurpose
          ? null
          : (selectedPurposeId ?? this.selectedPurposeId),
      receiveDate: clearDate ? null : (receiveDate ?? this.receiveDate),
      copies: copies ?? this.copies,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      createdId: createdId ?? this.createdId,
      error: error,
    );
  }
}
