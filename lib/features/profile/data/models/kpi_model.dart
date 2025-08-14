import '../../domain/entities/kpi.dart';

class KpiModel extends Kpi {
  const KpiModel({
    required super.id,
    required super.title,
    required super.description,
    required super.targetValue,
    required super.currentValue,
    required super.unit,
    required super.period,
    required super.startDate,
    required super.endDate,
    required super.status,
    required super.progressPercentage,
    required super.weight,
    required super.fact,
    required super.kpiCalculation,
  });

  factory KpiModel.fromJson(Map<String, dynamic> json) {
    return KpiModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      targetValue: (json['targetValue'] as num).toDouble(),
      currentValue: (json['currentValue'] as num).toDouble(),
      unit: json['unit'] as String,
      period: KpiPeriod.values.firstWhere(
        (e) => e.toString().split('.').last == json['period'],
      ),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      status: KpiStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
      ),
      progressPercentage: (json['progressPercentage'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      fact: (json['fact'] as num).toDouble(),
      kpiCalculation: (json['kpiCalculation'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'targetValue': targetValue,
      'currentValue': currentValue,
      'unit': unit,
      'period': period.toString().split('.').last,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'status': status.toString().split('.').last,
      'progressPercentage': progressPercentage,
      'weight': weight,
      'fact': fact,
      'kpiCalculation': kpiCalculation,
    };
  }

  factory KpiModel.fromEntity(Kpi kpi) {
    return KpiModel(
      id: kpi.id,
      title: kpi.title,
      description: kpi.description,
      targetValue: kpi.targetValue,
      currentValue: kpi.currentValue,
      unit: kpi.unit,
      period: kpi.period,
      startDate: kpi.startDate,
      endDate: kpi.endDate,
      status: kpi.status,
      progressPercentage: kpi.progressPercentage,
      weight: kpi.weight,
      fact: kpi.fact,
      kpiCalculation: kpi.kpiCalculation,
    );
  }
}
