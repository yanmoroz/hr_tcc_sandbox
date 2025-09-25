import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/application_purpose.dart';

class EmploymentCertificateFormState {
  final List<ApplicationPurpose> purposes;
  final String? selectedPurposeId;
  final DateTime? receiveDate;
  final int copies;

  const EmploymentCertificateFormState({
    this.purposes = const [],
    this.selectedPurposeId,
    this.receiveDate,
    this.copies = 1,
  });

  bool get isValid =>
      selectedPurposeId != null && receiveDate != null && copies > 0;

  EmploymentCertificateFormState copyWith({
    List<ApplicationPurpose>? purposes,
    String? selectedPurposeId,
    bool clearSelectedPurpose = false,
    DateTime? receiveDate,
    bool clearReceiveDate = false,
    int? copies,
  }) {
    return EmploymentCertificateFormState(
      purposes: purposes ?? this.purposes,
      selectedPurposeId: clearSelectedPurpose
          ? null
          : (selectedPurposeId ?? this.selectedPurposeId),
      receiveDate: clearReceiveDate ? null : (receiveDate ?? this.receiveDate),
      copies: copies ?? this.copies,
    );
  }
}

class EmploymentCertificateFormCubit
    extends Cubit<EmploymentCertificateFormState> {
  EmploymentCertificateFormCubit()
    : super(const EmploymentCertificateFormState());

  void setPurposes(List<ApplicationPurpose> purposes) =>
      emit(state.copyWith(purposes: purposes));

  void selectPurpose(String id) => emit(state.copyWith(selectedPurposeId: id));

  void setDate(DateTime date) => emit(state.copyWith(receiveDate: date));

  void setCopies(int copies) => emit(state.copyWith(copies: copies));
}
