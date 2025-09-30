import '../entities/news.dart';

abstract class NewsRepository {
  Future<NewsListResult> getNews({
    int? category,
    int page = 0,
    int pageSize = 20,
  });
  Future<List<NewsCategory>> getCategories();
}
