import 'package:flutter_bloc/flutter_bloc.dart';

enum ParkingPassType { guest, permanent }

class ParkingFormState {
  final ParkingPassType passType;
  final String? purpose;
  final int? floor;
  final int? office;
  final String? carBrand;
  final String? carPlate;
  final DateTime? dateFrom;
  final DateTime? dateTo;
  final String? timeFrom;
  final String? timeTo;
  final List<String> visitors;

  const ParkingFormState({
    this.passType = ParkingPassType.guest,
    this.purpose,
    this.floor,
    this.office,
    this.carBrand,
    this.carPlate,
    this.dateFrom,
    this.dateTo,
    this.timeFrom,
    this.timeTo,
    this.visitors = const [],
  });

  bool get isValid =>
      (purpose != null && purpose!.isNotEmpty) &&
      (carBrand != null && carBrand!.isNotEmpty) &&
      (carPlate != null && carPlate!.isNotEmpty) &&
      dateFrom != null &&
      dateTo != null &&
      (visitors.isNotEmpty && visitors.first.trim().isNotEmpty);

  ParkingFormState copyWith({
    ParkingPassType? passType,
    String? purpose,
    bool clearPurpose = false,
    int? floor,
    bool clearFloor = false,
    int? office,
    bool clearOffice = false,
    String? carBrand,
    bool clearCarBrand = false,
    String? carPlate,
    bool clearCarPlate = false,
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
    return ParkingFormState(
      passType: passType ?? this.passType,
      purpose: clearPurpose ? null : (purpose ?? this.purpose),
      floor: clearFloor ? null : (floor ?? this.floor),
      office: clearOffice ? null : (office ?? this.office),
      carBrand: clearCarBrand ? null : (carBrand ?? this.carBrand),
      carPlate: clearCarPlate ? null : (carPlate ?? this.carPlate),
      dateFrom: clearDateFrom ? null : (dateFrom ?? this.dateFrom),
      dateTo: clearDateTo ? null : (dateTo ?? this.dateTo),
      timeFrom: clearTimeFrom ? null : (timeFrom ?? this.timeFrom),
      timeTo: clearTimeTo ? null : (timeTo ?? this.timeTo),
      visitors: visitors ?? this.visitors,
    );
  }
}

class ParkingFormCubit extends Cubit<ParkingFormState> {
  ParkingFormCubit() : super(const ParkingFormState());

  void setPassType(ParkingPassType type) =>
      emit(state.copyWith(passType: type));
  void setPurpose(String value) => emit(state.copyWith(purpose: value));
  void setFloor(int value) => emit(state.copyWith(floor: value));
  void setOffice(int value) => emit(state.copyWith(office: value));
  void setCarBrand(String value) => emit(state.copyWith(carBrand: value));
  void setCarPlate(String value) => emit(state.copyWith(carPlate: value));
  void setDateFrom(DateTime d) => emit(state.copyWith(dateFrom: d));
  void setDateTo(DateTime d) => emit(state.copyWith(dateTo: d));
  void setTimeFrom(String t) => emit(state.copyWith(timeFrom: t));
  void setTimeTo(String t) => emit(state.copyWith(timeTo: t));
  void setVisitorPrimary(String name) {
    final updated = List<String>.from(state.visitors);
    if (updated.isEmpty) {
      updated.add(name);
    } else {
      updated[0] = name;
    }
    emit(state.copyWith(visitors: updated));
  }
}
