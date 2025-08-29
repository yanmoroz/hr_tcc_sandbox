class ApplicationCategory {
  final String id;
  final String name;
  final int count;

  const ApplicationCategory({
    required this.id,
    required this.name,
    required this.count,
  });

  ApplicationCategory copyWith({String? id, String? name, int? count}) {
    return ApplicationCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      count: count ?? this.count,
    );
  }
}
