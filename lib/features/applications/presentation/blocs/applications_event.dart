import '../../../applications/domain/entities/application_category.dart';

abstract class ApplicationsEvent {}

class ApplicationsStarted extends ApplicationsEvent {}

class ApplicationsSearchChanged extends ApplicationsEvent {
  final String query;
  ApplicationsSearchChanged(this.query);
}

class ApplicationsCategoryChanged extends ApplicationsEvent {
  final ApplicationCategory category;
  ApplicationsCategoryChanged(this.category);
}
