import '../../domain/entities/application_type.dart';
import '../blocs/new_application_state.dart';

abstract class NewApplicationEvent {}

class NewApplicationStarted extends NewApplicationEvent {
  final ApplicationType applicationType;
  NewApplicationStarted(this.applicationType);
}

class NewApplicationPurposeSelected extends NewApplicationEvent {
  final String purposeId;
  NewApplicationPurposeSelected(this.purposeId);
}

class NewApplicationDateChanged extends NewApplicationEvent {
  final DateTime date;
  NewApplicationDateChanged(this.date);
}

class NewApplicationCopiesChanged extends NewApplicationEvent {
  final int copies;
  NewApplicationCopiesChanged(this.copies);
}

class NewApplicationSubmitted extends NewApplicationEvent {}

// Parking-specific events
class ParkingPassTypeChanged extends NewApplicationEvent {
  final ParkingPassType type;
  ParkingPassTypeChanged(this.type);
}

class ParkingPurposeChanged extends NewApplicationEvent {
  final String purpose;
  ParkingPurposeChanged(this.purpose);
}

class ParkingFloorChanged extends NewApplicationEvent {
  final int floor;
  ParkingFloorChanged(this.floor);
}

class ParkingOfficeChanged extends NewApplicationEvent {
  final int office;
  ParkingOfficeChanged(this.office);
}

class ParkingCarBrandChanged extends NewApplicationEvent {
  final String brand;
  ParkingCarBrandChanged(this.brand);
}

class ParkingCarPlateChanged extends NewApplicationEvent {
  final String plate;
  ParkingCarPlateChanged(this.plate);
}

class ParkingDateOnlyChanged extends NewApplicationEvent {
  final DateTime date;
  ParkingDateOnlyChanged(this.date);
}

class ParkingDateFromChanged extends NewApplicationEvent {
  final DateTime date;
  ParkingDateFromChanged(this.date);
}

class ParkingDateToChanged extends NewApplicationEvent {
  final DateTime date;
  ParkingDateToChanged(this.date);
}

class ParkingTimeFromChanged extends NewApplicationEvent {
  final String time;
  ParkingTimeFromChanged(this.time);
}

class ParkingTimeToChanged extends NewApplicationEvent {
  final String time;
  ParkingTimeToChanged(this.time);
}

class ParkingVisitorPrimaryChanged extends NewApplicationEvent {
  final String name;
  ParkingVisitorPrimaryChanged(this.name);
}

// Absence-specific events
class AbsenceTypeChanged extends NewApplicationEvent {
  final String type;
  AbsenceTypeChanged(this.type);
}

class AbsenceDateChanged extends NewApplicationEvent {
  final DateTime date;
  AbsenceDateChanged(this.date);
}

class AbsenceTimeChanged extends NewApplicationEvent {
  final String time; // formatted HH:mm
  AbsenceTimeChanged(this.time);
}

class AbsenceReasonChanged extends NewApplicationEvent {
  final String reason;
  AbsenceReasonChanged(this.reason);
}
