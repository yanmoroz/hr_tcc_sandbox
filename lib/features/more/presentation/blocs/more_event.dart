import 'package:equatable/equatable.dart';

abstract class MoreEvent extends Equatable {
  const MoreEvent();
  @override
  List<Object?> get props => [];
}

class MoreRequested extends MoreEvent {
  const MoreRequested();
}
