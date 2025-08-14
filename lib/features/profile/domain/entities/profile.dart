import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String workPhone;
  final String workExtension;
  final String position;
  final String department;
  final DateTime hireDate;
  final String avatarUrl;
  final String employeeId;
  final ProfileStatus status;
  final double totalIncome;
  final double salary;
  final double bonus;
  final int remainingLeaveDays;
  final double kpiProgress;

  const Profile({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.workPhone,
    required this.workExtension,
    required this.position,
    required this.department,
    required this.hireDate,
    required this.avatarUrl,
    required this.employeeId,
    required this.status,
    required this.totalIncome,
    required this.salary,
    required this.bonus,
    required this.remainingLeaveDays,
    required this.kpiProgress,
  });

  @override
  List<Object?> get props => [
    id,
    fullName,
    email,
    phone,
    workPhone,
    workExtension,
    position,
    department,
    hireDate,
    avatarUrl,
    employeeId,
    status,
    totalIncome,
    salary,
    bonus,
    remainingLeaveDays,
    kpiProgress,
  ];
}

enum ProfileStatus { active, inactive, terminated }
