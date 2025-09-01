import 'package:flutter_bloc/flutter_bloc.dart';

enum AccessPassType { guest, permanent }

class AccessCardFormState {
  final AccessPassType passType;
  final String? purpose;
  final int? floor;
  final int? office;
  final DateTime? dateFrom;
  final DateTime? dateTo;
  final String? timeFrom;
  final String? timeTo;
  final List<String> visitors;

  const AccessCardFormState({
    this.passType = AccessPassType.guest,
    this.purpose,
    this.floor,
    this.office,
    this.dateFrom,
    this.dateTo,
    this.timeFrom,
    this.timeTo,
    this.visitors = const [''],
  });

  bool get isValid =>
      purpose != null &&
      floor != null &&
      office != null &&
      dateFrom != null &&
      dateTo != null &&
      (timeFrom != null && timeFrom!.isNotEmpty) &&
      (timeTo != null && timeTo!.isNotEmpty) &&
      visitors.isNotEmpty &&
      visitors.first.trim().isNotEmpty;

  AccessCardFormState copyWith({
    AccessPassType? passType,
    String? purpose,
    bool clearPurpose = false,
    int? floor,
    bool clearFloor = false,
    int? office,
    bool clearOffice = false,
    DateTime? dateFrom,
    bool clearDateFrom = false,
    DateTime? dateTo,
    bool clearDateTo = false,
    String? timeFrom,
    bool clearTimeFrom = false,
    String? timeTo,
    bool clearTimeTo = false,
    List<String>? visitors,
  }) {
    return AccessCardFormState(
      passType: passType ?? this.passType,
      purpose: clearPurpose ? null : (purpose ?? this.purpose),
      floor: clearFloor ? null : (floor ?? this.floor),
      office: clearOffice ? null : (office ?? this.office),
      dateFrom: clearDateFrom ? null : (dateFrom ?? this.dateFrom),
      dateTo: clearDateTo ? null : (dateTo ?? this.dateTo),
      timeFrom: clearTimeFrom ? null : (timeFrom ?? this.timeFrom),
      timeTo: clearTimeTo ? null : (timeTo ?? this.timeTo),
      visitors: visitors ?? this.visitors,
    );
  }
}

class AccessCardFormCubit extends Cubit<AccessCardFormState> {
  AccessCardFormCubit() : super(const AccessCardFormState());

  void setPassType(AccessPassType v) => emit(state.copyWith(passType: v));
  void setPurpose(String v) => emit(state.copyWith(purpose: v));
  void setFloor(int v) => emit(state.copyWith(floor: v));
  void setOffice(int v) => emit(state.copyWith(office: v));
  void setDateFrom(DateTime d) => emit(state.copyWith(dateFrom: d));
  void setDateTo(DateTime d) => emit(state.copyWith(dateTo: d));
  void setTimeFrom(String v) => emit(state.copyWith(timeFrom: v));
  void setTimeTo(String v) => emit(state.copyWith(timeTo: v));

  void setVisitorAt(int index, String value) {
    final list = List<String>.from(state.visitors);
    if (index >= 0 && index < list.length) {
      list[index] = value;
      emit(state.copyWith(visitors: list));
    }
  }

  void addVisitor() {
    if (state.visitors.length >= 5) return;
    final list = List<String>.from(state.visitors)..add('');
    emit(state.copyWith(visitors: list));
  }

  void removeVisitor(int index) {
    final list = List<String>.from(state.visitors);
    if (list.length > 1 && index >= 0 && index < list.length) {
      list.removeAt(index);
      emit(state.copyWith(visitors: list));
    }
  }
}
