import 'package:equatable/equatable.dart';

abstract class PinEvent extends Equatable {
  const PinEvent();

  @override
  List<Object?> get props => [];
}

class PinDigitEntered extends PinEvent {
  final String digit;

  const PinDigitEntered(this.digit);

  @override
  List<Object?> get props => [digit];
}

class PinDigitDeleted extends PinEvent {
  const PinDigitDeleted();
}

class PinCreationConfirmed extends PinEvent {
  final String pin;

  const PinCreationConfirmed(this.pin);

  @override
  List<Object?> get props => [pin];
}

class PinRepeated extends PinEvent {
  final String pin;

  const PinRepeated(this.pin);

  @override
  List<Object?> get props => [pin];
}

class PinReset extends PinEvent {
  const PinReset();
}

class PinValidationFailed extends PinEvent {
  const PinValidationFailed();
}

class StartPinCreation extends PinEvent {
  const StartPinCreation();
}

class StartPinConfirmation extends PinEvent {
  final String originalPin;

  const StartPinConfirmation(this.originalPin);

  @override
  List<Object?> get props => [originalPin];
}
