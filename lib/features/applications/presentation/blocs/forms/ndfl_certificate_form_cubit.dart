import 'package:flutter_bloc/flutter_bloc.dart';

class NdflCertificateFormState {
  final String? purpose;
  final DateTime? dateFrom;
  final DateTime? dateTo;

  const NdflCertificateFormState({this.purpose, this.dateFrom, this.dateTo});

  bool get isValid => purpose != null && dateFrom != null && dateTo != null;

  NdflCertificateFormState copyWith({
    String? purpose,
    bool clearPurpose = false,
    DateTime? dateFrom,
    bool clearDateFrom = false,
    DateTime? dateTo,
    bool clearDateTo = false,
  }) {
    return NdflCertificateFormState(
      purpose: clearPurpose ? null : (purpose ?? this.purpose),
      dateFrom: clearDateFrom ? null : (dateFrom ?? this.dateFrom),
      dateTo: clearDateTo ? null : (dateTo ?? this.dateTo),
    );
  }
}

class NdflCertificateFormCubit extends Cubit<NdflCertificateFormState> {
  NdflCertificateFormCubit() : super(const NdflCertificateFormState());

  void setPurpose(String value) => emit(state.copyWith(purpose: value));
  void setDateFrom(DateTime date) => emit(state.copyWith(dateFrom: date));
  void setDateTo(DateTime date) => emit(state.copyWith(dateTo: date));
}
