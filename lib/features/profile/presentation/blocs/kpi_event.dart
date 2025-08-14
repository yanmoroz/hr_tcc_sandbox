import 'package:equatable/equatable.dart';
import '../../domain/entities/kpi.dart';

abstract class KpiEvent extends Equatable {
  const KpiEvent();

  @override
  List<Object?> get props => [];
}

class LoadKpis extends KpiEvent {
  final String userId;
  final KpiPeriod period;

  const LoadKpis({required this.userId, required this.period});

  @override
  List<Object?> get props => [userId, period];
}

class LoadKpiById extends KpiEvent {
  final String kpiId;

  const LoadKpiById(this.kpiId);

  @override
  List<Object?> get props => [kpiId];
}
