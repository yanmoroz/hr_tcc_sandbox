import '../../domain/entities/news.dart';
import '../../domain/repositories/news_repository.dart';
import '../datasources/news_local_datasource.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsLocalDataSource _local;

  NewsRepositoryImpl(this._local);

  @override
  Future<List<NewsCategory>> getCategories() => _local.getCategories();

  @override
  Future<List<NewsItem>> getNews() => _local.getNews();
}
