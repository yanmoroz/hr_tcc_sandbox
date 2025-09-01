import 'package:flutter_bloc/flutter_bloc.dart';

class EmploymentRecordCopyFormState {
  final int copies;
  final DateTime? receiptDate;
  final bool isCertified;
  final bool isScanByMail;

  const EmploymentRecordCopyFormState({
    this.copies = 1,
    this.receiptDate,
    this.isCertified = false,
    this.isScanByMail = false,
  });

  bool get isValid => receiptDate != null && copies > 0;

  EmploymentRecordCopyFormState copyWith({
    int? copies,
    DateTime? receiptDate,
    bool clearReceiptDate = false,
    bool? isCertified,
    bool? isScanByMail,
  }) {
    return EmploymentRecordCopyFormState(
      copies: copies ?? this.copies,
      receiptDate: clearReceiptDate ? null : (receiptDate ?? this.receiptDate),
      isCertified: isCertified ?? this.isCertified,
      isScanByMail: isScanByMail ?? this.isScanByMail,
    );
  }
}

class EmploymentRecordCopyFormCubit
    extends Cubit<EmploymentRecordCopyFormState> {
  EmploymentRecordCopyFormCubit()
    : super(const EmploymentRecordCopyFormState());

  void setCopies(int copies) => emit(state.copyWith(copies: copies));
  void setReceiptDate(DateTime date) => emit(state.copyWith(receiptDate: date));
  void setCertified(bool value) => emit(state.copyWith(isCertified: value));
  void setScanByMail(bool value) => emit(state.copyWith(isScanByMail: value));
}
