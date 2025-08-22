class Contact {
  final String id;
  final String fullName;
  final String avatarUrl;
  final List<String> roles;
  final List<String> departments;
  final String mobilePhone;
  final String workPhone;
  final String email;

  const Contact({
    required this.id,
    required this.fullName,
    required this.avatarUrl,
    required this.roles,
    required this.departments,
    required this.mobilePhone,
    required this.workPhone,
    required this.email,
  });

  String get initials {
    final names = fullName.split(' ');
    if (names.length >= 2) {
      return '${names[0][0]}${names[1][0]}'.toUpperCase();
    } else if (names.isNotEmpty) {
      return names[0][0].toUpperCase();
    }
    return '';
  }
}
