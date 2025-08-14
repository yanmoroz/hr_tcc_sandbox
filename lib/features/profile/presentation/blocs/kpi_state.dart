import 'package:equatable/equatable.dart';
import '../../domain/entities/kpi.dart';

abstract class KpiState extends Equatable {
  const KpiState();

  @override
  List<Object?> get props => [];
}

class KpiInitial extends KpiState {}

class KpiLoading extends KpiState {}

class KpisLoaded extends KpiState {
  final List<Kpi> kpis;
  final KpiPeriod period;

  const KpisLoaded({required this.kpis, required this.period});

  @override
  List<Object?> get props => [kpis, period];
}

class KpiLoaded extends KpiState {
  final Kpi kpi;

  const KpiLoaded(this.kpi);

  @override
  List<Object?> get props => [kpi];
}

class KpiError extends KpiState {
  final String message;

  const KpiError(this.message);

  @override
  List<Object?> get props => [message];
}
