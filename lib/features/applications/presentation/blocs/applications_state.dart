import '../../domain/entities/application_category.dart';
import '../../domain/entities/application_template.dart';

class ApplicationsState {
  final bool isLoading;
  final String query;
  final List<ApplicationCategory> categories;
  final ApplicationCategory? selectedCategory;
  final List<ApplicationTemplate> allTemplates;
  final List<ApplicationTemplate> filteredTemplates;

  const ApplicationsState({
    this.isLoading = false,
    this.query = '',
    this.categories = const [],
    this.selectedCategory,
    this.allTemplates = const [],
    this.filteredTemplates = const [],
  });

  ApplicationsState copyWith({
    bool? isLoading,
    String? query,
    List<ApplicationCategory>? categories,
    ApplicationCategory? selectedCategory,
    bool clearSelectedCategory = false,
    List<ApplicationTemplate>? allTemplates,
    List<ApplicationTemplate>? filteredTemplates,
  }) {
    return ApplicationsState(
      isLoading: isLoading ?? this.isLoading,
      query: query ?? this.query,
      categories: categories ?? this.categories,
      selectedCategory: clearSelectedCategory
          ? null
          : (selectedCategory ?? this.selectedCategory),
      allTemplates: allTemplates ?? this.allTemplates,
      filteredTemplates: filteredTemplates ?? this.filteredTemplates,
    );
  }
}
