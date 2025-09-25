import '../entities/news.dart';

abstract class NewsRepository {
  Future<List<NewsItem>> getNews();
  Future<List<NewsCategory>> getCategories();
}
