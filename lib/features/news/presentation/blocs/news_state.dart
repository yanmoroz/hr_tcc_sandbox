import 'package:equatable/equatable.dart';
import '../../domain/entities/news.dart';

class NewsState extends Equatable {
  final bool isLoading;
  final String query;
  final String selectedCategoryId; // 'all' for all categories
  final List<NewsCategory> categories;
  final List<NewsItem> allNews;
  final List<NewsItem> filteredNews;
  final String? error;

  const NewsState({
    this.isLoading = false,
    this.query = '',
    this.selectedCategoryId = 'all',
    this.categories = const [],
    this.allNews = const [],
    this.filteredNews = const [],
    this.error,
  });

  NewsState copyWith({
    bool? isLoading,
    String? query,
    String? selectedCategoryId,
    List<NewsCategory>? categories,
    List<NewsItem>? allNews,
    List<NewsItem>? filteredNews,
    String? error,
  }) {
    return NewsState(
      isLoading: isLoading ?? this.isLoading,
      query: query ?? this.query,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      categories: categories ?? this.categories,
      allNews: allNews ?? this.allNews,
      filteredNews: filteredNews ?? this.filteredNews,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    query,
    selectedCategoryId,
    categories,
    allNews,
    filteredNews,
    error,
  ];
}
