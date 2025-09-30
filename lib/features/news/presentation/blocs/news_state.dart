import 'package:equatable/equatable.dart';
import '../../domain/entities/news.dart';

class NewsState extends Equatable {
  final bool isLoading;
  final bool isLoadingMore;
  final bool isRefreshing;
  final String query;
  final String selectedCategoryId; // 'all' for all categories
  final List<NewsCategory> categories;
  final List<NewsItem> allNews;
  final List<NewsItem> filteredNews;
  final bool hasMore;
  final int currentPage;
  final String? error;

  const NewsState({
    this.isLoading = false,
    this.isLoadingMore = false,
    this.isRefreshing = false,
    this.query = '',
    this.selectedCategoryId = 'all',
    this.categories = const [],
    this.allNews = const [],
    this.filteredNews = const [],
    this.hasMore = true,
    this.currentPage = 0,
    this.error,
  });

  NewsState copyWith({
    bool? isLoading,
    bool? isLoadingMore,
    bool? isRefreshing,
    String? query,
    String? selectedCategoryId,
    List<NewsCategory>? categories,
    List<NewsItem>? allNews,
    List<NewsItem>? filteredNews,
    bool? hasMore,
    int? currentPage,
    String? error,
  }) {
    return NewsState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      query: query ?? this.query,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      categories: categories ?? this.categories,
      allNews: allNews ?? this.allNews,
      filteredNews: filteredNews ?? this.filteredNews,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isLoadingMore,
    isRefreshing,
    query,
    selectedCategoryId,
    categories,
    allNews,
    filteredNews,
    hasMore,
    currentPage,
    error,
  ];
}
