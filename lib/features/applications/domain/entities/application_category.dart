enum ApplicationCategory {
  all('Все'),
  training('Обучение'),
  officeOperation('Эксплуатация и обеспечение офиса'),
  corporateServices('Корпоративные сервисы'),
  hrServices('HR-сервисы'),
  regimeManagement('Управление режима');

  const ApplicationCategory(this.displayName);

  final String displayName;

  @override
  String toString() => displayName;
}
