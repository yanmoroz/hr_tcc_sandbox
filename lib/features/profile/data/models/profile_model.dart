import '../../domain/entities/profile.dart';

class ProfileModel extends Profile {
  const ProfileModel({
    required super.id,
    required super.fullName,
    required super.email,
    required super.phone,
    required super.workPhone,
    required super.workExtension,
    required super.position,
    required super.department,
    required super.hireDate,
    required super.avatarUrl,
    required super.employeeId,
    required super.status,
    required super.totalIncome,
    required super.salary,
    required super.bonus,
    required super.remainingLeaveDays,
    required super.kpiProgress,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      workPhone: json['workPhone'] as String,
      workExtension: json['workExtension'] as String,
      position: json['position'] as String,
      department: json['department'] as String,
      hireDate: DateTime.parse(json['hireDate'] as String),
      avatarUrl: json['avatarUrl'] as String,
      employeeId: json['employeeId'] as String,
      status: ProfileStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
      ),
      totalIncome: (json['totalIncome'] as num).toDouble(),
      salary: (json['salary'] as num).toDouble(),
      bonus: (json['bonus'] as num).toDouble(),
      remainingLeaveDays: json['remainingLeaveDays'] as int,
      kpiProgress: (json['kpiProgress'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'workPhone': workPhone,
      'workExtension': workExtension,
      'position': position,
      'department': department,
      'hireDate': hireDate.toIso8601String(),
      'avatarUrl': avatarUrl,
      'employeeId': employeeId,
      'status': status.toString().split('.').last,
      'totalIncome': totalIncome,
      'salary': salary,
      'bonus': bonus,
      'remainingLeaveDays': remainingLeaveDays,
      'kpiProgress': kpiProgress,
    };
  }

  factory ProfileModel.fromEntity(Profile profile) {
    return ProfileModel(
      id: profile.id,
      fullName: profile.fullName,
      email: profile.email,
      phone: profile.phone,
      workPhone: profile.workPhone,
      workExtension: profile.workExtension,
      position: profile.position,
      department: profile.department,
      hireDate: profile.hireDate,
      avatarUrl: profile.avatarUrl,
      employeeId: profile.employeeId,
      status: profile.status,
      totalIncome: profile.totalIncome,
      salary: profile.salary,
      bonus: profile.bonus,
      remainingLeaveDays: profile.remainingLeaveDays,
      kpiProgress: profile.kpiProgress,
    );
  }
}
