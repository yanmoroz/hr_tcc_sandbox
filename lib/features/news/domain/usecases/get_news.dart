import '../entities/news.dart';
import '../repositories/news_repository.dart';

class GetNewsUseCase {
  final NewsRepository _repository;

  const GetNewsUseCase(this._repository);

  Future<List<NewsItem>> call() => _repository.getNews();
}
