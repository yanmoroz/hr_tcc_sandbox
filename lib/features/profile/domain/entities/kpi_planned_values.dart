import 'package:equatable/equatable.dart';

class KpiPlannedValues extends Equatable {
  final double averagePayroll;
  final double targetBonus;
  final double bonusPercentage;

  const KpiPlannedValues({
    required this.averagePayroll,
    required this.targetBonus,
    required this.bonusPercentage,
  });

  @override
  List<Object?> get props => [averagePayroll, targetBonus, bonusPercentage];
}
