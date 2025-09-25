import 'package:flutter_bloc/flutter_bloc.dart';

class AbsenceFormState {
  final String? type;
  final DateTime? date;
  final String? time; // HH:mm
  final String? reason;

  const AbsenceFormState({this.type, this.date, this.time, this.reason});

  bool get isValid =>
      (type != null && type!.isNotEmpty) && date != null && (time != null);

  AbsenceFormState copyWith({
    String? type,
    bool clearType = false,
    DateTime? date,
    bool clearDate = false,
    String? time,
    bool clearTime = false,
    String? reason,
    bool clearReason = false,
  }) {
    return AbsenceFormState(
      type: clearType ? null : (type ?? this.type),
      date: clearDate ? null : (date ?? this.date),
      time: clearTime ? null : (time ?? this.time),
      reason: clearReason ? null : (reason ?? this.reason),
    );
  }
}

class AbsenceFormCubit extends Cubit<AbsenceFormState> {
  AbsenceFormCubit() : super(const AbsenceFormState());

  void setType(String type) => emit(state.copyWith(type: type));
  void setDate(DateTime date) => emit(state.copyWith(date: date));
  void setTime(String time) => emit(state.copyWith(time: time));
  void setReason(String reason) => emit(state.copyWith(reason: reason));
}
