import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/application_template.dart';
import '../../domain/entities/application_category.dart';
import '../../domain/usecases/get_application_categories.dart';
import '../../domain/usecases/get_application_templates.dart';
import 'applications_event.dart';
import 'applications_state.dart';

class ApplicationsBloc extends Bloc<ApplicationsEvent, ApplicationsState> {
  final GetApplicationCategoriesUseCase _getCategories;
  final GetApplicationTemplatesUseCase _getTemplates;

  ApplicationsBloc({
    required GetApplicationCategoriesUseCase getCategories,
    required GetApplicationTemplatesUseCase getTemplates,
  }) : _getCategories = getCategories,
       _getTemplates = getTemplates,
       super(const ApplicationsState()) {
    on<ApplicationsStarted>(_onStarted);
    on<ApplicationsSearchChanged>(_onSearchChanged);
    on<ApplicationsCategoryChanged>(_onCategoryChanged);
  }

  Future<void> _onStarted(
    ApplicationsStarted event,
    Emitter<ApplicationsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final categories = await _getCategories();
    final templates = await _getTemplates();
    final selected = categories.isNotEmpty ? categories.first : null;
    emit(
      state.copyWith(
        isLoading: false,
        categories: categories,
        selectedCategory: selected,
        allTemplates: templates,
      ),
    );
    _applyFilters(emit);
  }

  void _onSearchChanged(
    ApplicationsSearchChanged event,
    Emitter<ApplicationsState> emit,
  ) {
    emit(state.copyWith(query: event.query));
    _applyFilters(emit);
  }

  void _onCategoryChanged(
    ApplicationsCategoryChanged event,
    Emitter<ApplicationsState> emit,
  ) {
    emit(state.copyWith(selectedCategory: event.category));
    _applyFilters(emit);
  }

  void _applyFilters(Emitter<ApplicationsState> emit) {
    final String q = state.query.trim().toLowerCase();
    final ApplicationCategory? selectedCategory = state.selectedCategory;

    List<ApplicationTemplate> filtered = state.allTemplates;

    if (selectedCategory != null &&
        selectedCategory != ApplicationCategory.all) {
      filtered = filtered.where((t) => t.category == selectedCategory).toList();
    }
    if (q.isNotEmpty) {
      filtered = filtered
          .where((t) => t.title.toLowerCase().contains(q))
          .toList();
    }

    emit(state.copyWith(filteredTemplates: filtered));
  }
}
