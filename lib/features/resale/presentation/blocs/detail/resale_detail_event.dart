import 'package:equatable/equatable.dart';

abstract class ResaleDetailEvent extends Equatable {
  const ResaleDetailEvent();
  @override
  List<Object?> get props => [];
}

class ResaleDetailRequested extends ResaleDetailEvent {
  final String itemId;
  const ResaleDetailRequested(this.itemId);
  @override
  List<Object?> get props => [itemId];
}

class ResaleDetailToggleBooking extends ResaleDetailEvent {
  final String itemId;
  const ResaleDetailToggleBooking(this.itemId);
  @override
  List<Object?> get props => [itemId];
}
