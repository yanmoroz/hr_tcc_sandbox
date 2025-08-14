import 'package:equatable/equatable.dart';

abstract class PinState extends Equatable {
  const PinState();

  @override
  List<Object?> get props => [];
}

class PinInitial extends PinState {
  const PinInitial();
}

class PinCreating extends PinState {
  final String currentPin;
  final int digitCount;

  const PinCreating({required this.currentPin, required this.digitCount});

  @override
  List<Object?> get props => [currentPin, digitCount];
}

class PinConfirming extends PinState {
  final String originalPin;
  final String currentPin;
  final int digitCount;

  const PinConfirming({
    required this.originalPin,
    required this.currentPin,
    required this.digitCount,
  });

  @override
  List<Object?> get props => [originalPin, currentPin, digitCount];
}

class PinCreatingLoading extends PinState {
  const PinCreatingLoading();
}

class PinConfirmingLoading extends PinState {
  const PinConfirmingLoading();
}

class PinCreated extends PinState {
  final String pin;

  const PinCreated(this.pin);

  @override
  List<Object?> get props => [pin];
}

class PinConfirmed extends PinState {
  const PinConfirmed();
}

class PinError extends PinState {
  final String message;

  const PinError(this.message);

  @override
  List<Object?> get props => [message];
}

class PinMismatch extends PinState {
  const PinMismatch();
}
