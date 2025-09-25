import 'package:equatable/equatable.dart';

enum ResaleFilter { all, booked }

abstract class ResaleEvent extends Equatable {
  const ResaleEvent();
  @override
  List<Object?> get props => [];
}

class ResaleRequested extends ResaleEvent {}

class ResaleFilterChanged extends ResaleEvent {
  final ResaleFilter filter;
  const ResaleFilterChanged(this.filter);
  @override
  List<Object?> get props => [filter];
}

class ResaleSearchChanged extends ResaleEvent {
  final String query;
  const ResaleSearchChanged(this.query);
  @override
  List<Object?> get props => [query];
}

class ResaleToggleBooking extends ResaleEvent {
  final String itemId;
  const ResaleToggleBooking(this.itemId);
  @override
  List<Object?> get props => [itemId];
}

class ResaleItemDetailRequested extends ResaleEvent {
  final String itemId;
  const ResaleItemDetailRequested(this.itemId);
  @override
  List<Object?> get props => [itemId];
}
