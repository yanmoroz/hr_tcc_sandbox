import '../../domain/entities/application_purpose.dart';
import '../../domain/entities/application_type.dart';

enum ParkingPassType { guest, permanent }

class NewApplicationState {
  final bool isLoading;
  final ApplicationType applicationType;
  final List<ApplicationPurpose> purposes;
  final String? selectedPurposeId;
  final DateTime? receiveDate;
  final int copies;
  final bool isSubmitting;
  final String? createdId;
  final String? error;

  // Parking specific
  final ParkingPassType parkingPassType;
  final String? parkingPurpose;
  final int? parkingFloor;
  final int? parkingOffice;
  final String? carBrand;
  final String? carPlate;
  final DateTime? parkingDateFrom;
  final DateTime? parkingDateTo;
  final String? timeFrom;
  final String? timeTo;
  final List<String> visitors;

  const NewApplicationState({
    this.isLoading = false,
    required this.applicationType,
    this.purposes = const [],
    this.selectedPurposeId,
    this.receiveDate,
    this.copies = 1,
    this.isSubmitting = false,
    this.createdId,
    this.error,
    this.parkingPassType = ParkingPassType.guest,
    this.parkingPurpose,
    this.parkingFloor,
    this.parkingOffice,
    this.carBrand,
    this.carPlate,
    this.parkingDateFrom,
    this.parkingDateTo,
    this.timeFrom,
    this.timeTo,
    this.visitors = const [],
  });

  bool get canSubmit {
    if (applicationType == ApplicationType.employmentCertificate) {
      return selectedPurposeId != null &&
          receiveDate != null &&
          copies > 0 &&
          !isSubmitting;
    }
    if (applicationType == ApplicationType.parking) {
      return (parkingPurpose != null && parkingPurpose!.isNotEmpty) &&
          (carBrand != null && carBrand!.isNotEmpty) &&
          (carPlate != null && carPlate!.isNotEmpty) &&
          parkingDateFrom != null &&
          parkingDateTo != null &&
          (visitors.isNotEmpty && visitors.first.trim().isNotEmpty) &&
          !isSubmitting;
    }
    return !isSubmitting;
  }

  NewApplicationState copyWith({
    bool? isLoading,
    ApplicationType? applicationType,
    List<ApplicationPurpose>? purposes,
    String? selectedPurposeId,
    bool clearSelectedPurpose = false,
    DateTime? receiveDate,
    bool clearDate = false,
    int? copies,
    bool? isSubmitting,
    String? createdId,
    String? error,
    // Parking specific
    ParkingPassType? parkingPassType,
    String? parkingPurpose,
    bool clearParkingPurpose = false,
    int? parkingFloor,
    bool clearParkingFloor = false,
    int? parkingOffice,
    bool clearParkingOffice = false,
    String? carBrand,
    bool clearCarBrand = false,
    String? carPlate,
    bool clearCarPlate = false,
    DateTime? parkingDateFrom,
    bool clearParkingDateFrom = false,
    DateTime? parkingDateTo,
    bool clearParkingDateTo = false,
    String? timeFrom,
    bool clearTimeFrom = false,
    String? timeTo,
    bool clearTimeTo = false,
    List<String>? visitors,
  }) {
    return NewApplicationState(
      isLoading: isLoading ?? this.isLoading,
      applicationType: applicationType ?? this.applicationType,
      purposes: purposes ?? this.purposes,
      selectedPurposeId: clearSelectedPurpose
          ? null
          : (selectedPurposeId ?? this.selectedPurposeId),
      receiveDate: clearDate ? null : (receiveDate ?? this.receiveDate),
      copies: copies ?? this.copies,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      createdId: createdId ?? this.createdId,
      error: error,
      parkingPassType: parkingPassType ?? this.parkingPassType,
      parkingPurpose: (clearParkingPurpose
          ? null
          : (parkingPurpose ?? this.parkingPurpose)),
      parkingFloor: (clearParkingFloor
          ? null
          : (parkingFloor ?? this.parkingFloor)),
      parkingOffice: (clearParkingOffice
          ? null
          : (parkingOffice ?? this.parkingOffice)),
      carBrand: (clearCarBrand ? null : (carBrand ?? this.carBrand)),
      carPlate: (clearCarPlate ? null : (carPlate ?? this.carPlate)),
      parkingDateFrom: clearParkingDateFrom
          ? null
          : (parkingDateFrom ?? this.parkingDateFrom),
      parkingDateTo: clearParkingDateTo
          ? null
          : (parkingDateTo ?? this.parkingDateTo),
      timeFrom: (clearTimeFrom ? null : (timeFrom ?? this.timeFrom)),
      timeTo: (clearTimeTo ? null : (timeTo ?? this.timeTo)),
      visitors: visitors ?? this.visitors,
    );
  }
}
