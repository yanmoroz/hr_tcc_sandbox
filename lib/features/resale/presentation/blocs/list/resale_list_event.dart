import 'package:equatable/equatable.dart';

abstract class ResaleListEvent extends Equatable {
  const ResaleListEvent();
  @override
  List<Object?> get props => [];
}

class ResaleListRequested extends ResaleListEvent {}

class ResaleListFilterChanged extends ResaleListEvent {
  final ResaleFilter filter;
  const ResaleListFilterChanged(this.filter);
  @override
  List<Object?> get props => [filter];
}

class ResaleListSearchChanged extends ResaleListEvent {
  final String query;
  const ResaleListSearchChanged(this.query);
  @override
  List<Object?> get props => [query];
}

class ResaleListToggleBooking extends ResaleListEvent {
  final String itemId;
  const ResaleListToggleBooking(this.itemId);
  @override
  List<Object?> get props => [itemId];
}

enum ResaleFilter { all, booked }
