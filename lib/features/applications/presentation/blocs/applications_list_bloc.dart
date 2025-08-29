import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/application.dart';
import '../../domain/entities/application_type.dart';
import '../../domain/usecases/get_applications.dart';
import 'applications_list_event.dart';
import 'applications_list_state.dart';

class ApplicationsListBloc
    extends Bloc<ApplicationsListEvent, ApplicationsListState> {
  final GetApplicationsUseCase _getApplications;

  ApplicationsListBloc({required GetApplicationsUseCase getApplications})
    : _getApplications = getApplications,
      super(const ApplicationsListState()) {
    on<ApplicationsListStarted>(_onStarted);
    on<ApplicationsListFilterChanged>(_onFilterChanged);
    on<ApplicationsListSearchChanged>(_onSearchChanged);
  }

  Future<void> _onStarted(
    ApplicationsListStarted event,
    Emitter<ApplicationsListState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final applications = await _getApplications();
    emit(state.copyWith(isLoading: false, allApplications: applications));
    _applyFilters(emit);
  }

  void _onFilterChanged(
    ApplicationsListFilterChanged event,
    Emitter<ApplicationsListState> emit,
  ) {
    emit(state.copyWith(selectedFilter: event.filter));
    _applyFilters(emit);
  }

  void _onSearchChanged(
    ApplicationsListSearchChanged event,
    Emitter<ApplicationsListState> emit,
  ) {
    emit(state.copyWith(query: event.query));
    _applyFilters(emit);
  }

  void _applyFilters(Emitter<ApplicationsListState> emit) {
    final String q = state.query.trim().toLowerCase();
    final selectedFilter = state.selectedFilter;

    List<Application> filtered = state.allApplications;

    // Apply status filter
    if (selectedFilter == ApplicationsFilter.inProgress) {
      filtered = filtered
          .where((app) => app.status == ApplicationStatus.inProgress)
          .toList();
    } else if (selectedFilter == ApplicationsFilter.done) {
      filtered = filtered
          .where((app) => app.status == ApplicationStatus.done)
          .toList();
    }

    // Apply search filter
    if (q.isNotEmpty) {
      filtered = filtered
          .where(
            (app) =>
                app.title.toLowerCase().contains(q) ||
                app.purpose.title.toLowerCase().contains(q),
          )
          .toList();
    }

    emit(state.copyWith(filteredApplications: filtered));
  }
}
