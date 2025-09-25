import 'package:equatable/equatable.dart';
import '../../../domain/entities/resale_item.dart';
import 'resale_list_event.dart';

class ResaleListState extends Equatable {
  final List<ResaleItem> allItems;
  final List<ResaleItem> filteredItems;
  final ResaleFilter currentFilter;
  final String searchQuery;
  final bool isLoading;
  final String? error;

  const ResaleListState({
    this.allItems = const [],
    this.filteredItems = const [],
    this.currentFilter = ResaleFilter.all,
    this.searchQuery = '',
    this.isLoading = false,
    this.error,
  });

  ResaleListState copyWith({
    List<ResaleItem>? allItems,
    List<ResaleItem>? filteredItems,
    ResaleFilter? currentFilter,
    String? searchQuery,
    bool? isLoading,
    String? error,
  }) {
    return ResaleListState(
      allItems: allItems ?? this.allItems,
      filteredItems: filteredItems ?? this.filteredItems,
      currentFilter: currentFilter ?? this.currentFilter,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    allItems,
    filteredItems,
    currentFilter,
    searchQuery,
    isLoading,
    error,
  ];
}
