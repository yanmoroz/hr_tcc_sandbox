import '../../domain/entities/news.dart';
import '../../domain/repositories/news_repository.dart';
import '../datasources/news_remote_datasource.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource _remote;

  NewsRepositoryImpl(this._remote);

  @override
  Future<List<NewsCategory>> getCategories() async {
    final categories = await _remote.getCategories();
    return categories.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<NewsListResult> getNews({
    int? category,
    int page = 0,
    int pageSize = 10,
  }) async {
    final response = await _remote.getNews(category: category, page: page);

    final items = response.items.map((dto) => dto.toEntity()).toList();

    // Calculate if there are more items available
    // hasMore is true if we haven't loaded all items yet based on total count
    final itemsLoadedSoFar = (page + 1) * pageSize;
    final hasMore = itemsLoadedSoFar < response.total;

    return NewsListResult(
      items: items,
      total: response.total,
      currentPage: page,
      hasMore: hasMore,
    );
  }
}
