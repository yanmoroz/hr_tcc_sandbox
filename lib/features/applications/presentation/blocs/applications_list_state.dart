import '../../domain/entities/application.dart';
import 'applications_list_event.dart';

class ApplicationsListState {
  final bool isLoading;
  final String query;
  final ApplicationsFilter selectedFilter;
  final List<Application> allApplications;
  final List<Application> filteredApplications;

  const ApplicationsListState({
    this.isLoading = false,
    this.query = '',
    this.selectedFilter = ApplicationsFilter.all,
    this.allApplications = const [],
    this.filteredApplications = const [],
  });

  ApplicationsListState copyWith({
    bool? isLoading,
    String? query,
    ApplicationsFilter? selectedFilter,
    List<Application>? allApplications,
    List<Application>? filteredApplications,
  }) {
    return ApplicationsListState(
      isLoading: isLoading ?? this.isLoading,
      query: query ?? this.query,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      allApplications: allApplications ?? this.allApplications,
      filteredApplications: filteredApplications ?? this.filteredApplications,
    );
  }
}
