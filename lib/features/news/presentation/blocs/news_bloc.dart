import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/news.dart';
import '../../domain/usecases/get_news.dart';
import '../../domain/usecases/get_news_categories.dart';
import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNewsUseCase _getNews;
  final GetNewsCategoriesUseCase _getCategories;

  NewsBloc({
    required GetNewsUseCase getNews,
    required GetNewsCategoriesUseCase getCategories,
  }) : _getNews = getNews,
       _getCategories = getCategories,
       super(const NewsState()) {
    on<NewsStarted>(_onStarted);
    on<NewsLoadMore>(_onLoadMore);
    on<NewsRefresh>(_onRefresh);
    on<NewsSearchChanged>(_onSearchChanged);
    on<NewsCategoryChanged>(_onCategoryChanged);
  }

  Future<void> _onStarted(NewsStarted event, Emitter<NewsState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final categories = await _getCategories();
      final categoryId = state.selectedCategoryId == 'all'
          ? null
          : int.tryParse(state.selectedCategoryId);

      final result = await _getNews(
        category: categoryId,
        page: 0,
        pageSize: 20,
      );

      emit(
        state.copyWith(
          isLoading: false,
          categories: categories,
          allNews: result.items,
          hasMore: result.hasMore,
          currentPage: result.currentPage,
        ),
      );
      _applyFilter(
        emit,
        query: state.query,
        categoryId: state.selectedCategoryId,
        items: result.items,
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onLoadMore(NewsLoadMore event, Emitter<NewsState> emit) async {
    if (!state.hasMore || state.isLoadingMore) return;

    emit(state.copyWith(isLoadingMore: true));
    try {
      final categoryId = state.selectedCategoryId == 'all'
          ? null
          : int.tryParse(state.selectedCategoryId);

      final result = await _getNews(
        category: categoryId,
        page: state.currentPage + 1,
        pageSize: 20,
      );

      final updatedNews = [...state.allNews, ...result.items];

      emit(
        state.copyWith(
          isLoadingMore: false,
          allNews: updatedNews,
          hasMore: result.hasMore,
          currentPage: result.currentPage,
        ),
      );
      _applyFilter(
        emit,
        query: state.query,
        categoryId: state.selectedCategoryId,
        items: updatedNews,
      );
    } catch (e) {
      emit(state.copyWith(isLoadingMore: false, error: e.toString()));
    }
  }

  Future<void> _onRefresh(NewsRefresh event, Emitter<NewsState> emit) async {
    emit(state.copyWith(isRefreshing: true, error: null));
    try {
      final categories = await _getCategories();
      final categoryId = state.selectedCategoryId == 'all'
          ? null
          : int.tryParse(state.selectedCategoryId);

      final result = await _getNews(
        category: categoryId,
        page: 0,
        pageSize: 20,
      );

      emit(
        state.copyWith(
          isRefreshing: false,
          categories: categories,
          allNews: result.items,
          hasMore: result.hasMore,
          currentPage: result.currentPage,
        ),
      );
      _applyFilter(
        emit,
        query: state.query,
        categoryId: state.selectedCategoryId,
        items: result.items,
      );
    } catch (e) {
      emit(state.copyWith(isRefreshing: false, error: e.toString()));
    }
  }

  void _onSearchChanged(NewsSearchChanged event, Emitter<NewsState> emit) {
    emit(state.copyWith(query: event.query));
    _applyFilter(
      emit,
      query: event.query,
      categoryId: state.selectedCategoryId,
      items: state.allNews,
    );
  }

  void _onCategoryChanged(NewsCategoryChanged event, Emitter<NewsState> emit) {
    emit(state.copyWith(selectedCategoryId: event.categoryId));
    _applyFilter(
      emit,
      query: state.query,
      categoryId: event.categoryId,
      items: state.allNews,
    );
  }

  void _applyFilter(
    Emitter<NewsState> emit, {
    required String query,
    required String categoryId,
    required List<NewsItem> items,
  }) {
    final normalizedQuery = query.trim().toLowerCase();
    List<NewsItem> filtered = items;

    if (categoryId != 'all') {
      filtered = filtered.where((n) => n.categoryId == categoryId).toList();
    }
    if (normalizedQuery.isNotEmpty) {
      filtered = filtered
          .where(
            (n) =>
                n.title.toLowerCase().contains(normalizedQuery) ||
                n.subtitle.toLowerCase().contains(normalizedQuery),
          )
          .toList();
    }

    filtered.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
    emit(state.copyWith(filteredNews: filtered));
  }
}
