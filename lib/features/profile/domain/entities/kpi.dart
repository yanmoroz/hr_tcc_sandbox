import 'package:equatable/equatable.dart';

class Kpi extends Equatable {
  final String id;
  final String title;
  final String description;
  final double targetValue;
  final double currentValue;
  final String unit;
  final KpiPeriod period;
  final DateTime startDate;
  final DateTime endDate;
  final KpiStatus status;
  final double progressPercentage;
  final double weight;
  final double fact;
  final double kpiCalculation;

  const Kpi({
    required this.id,
    required this.title,
    required this.description,
    required this.targetValue,
    required this.currentValue,
    required this.unit,
    required this.period,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.progressPercentage,
    required this.weight,
    required this.fact,
    required this.kpiCalculation,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    targetValue,
    currentValue,
    unit,
    period,
    startDate,
    endDate,
    status,
    progressPercentage,
    weight,
    fact,
    kpiCalculation,
  ];
}

enum KpiPeriod { daily, weekly, monthly, quarterly, halfYear, yearly }

enum KpiStatus { onTrack, behind, completed, notStarted }
