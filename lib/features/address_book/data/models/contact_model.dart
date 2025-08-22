import '../../domain/entities/contact.dart';

class ContactModel extends Contact {
  const ContactModel({
    required super.id,
    required super.fullName,
    required super.avatarUrl,
    required super.roles,
    required super.departments,
    required super.mobilePhone,
    required super.workPhone,
    required super.email,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      avatarUrl: json['avatarUrl'] as String? ?? '',
      roles: List<String>.from(json['roles'] ?? []),
      departments: List<String>.from(json['departments'] ?? []),
      mobilePhone: json['mobilePhone'] as String,
      workPhone: json['workPhone'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'avatarUrl': avatarUrl,
      'roles': roles,
      'departments': departments,
      'mobilePhone': mobilePhone,
      'workPhone': workPhone,
      'email': email,
    };
  }
}
