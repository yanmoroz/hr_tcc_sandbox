import '../entities/news.dart';
import '../repositories/news_repository.dart';

class GetNewsUseCase {
  final NewsRepository _repository;

  const GetNewsUseCase(this._repository);

  Future<NewsListResult> call({
    int? category,
    int page = 0,
    int pageSize = 20,
  }) => _repository.getNews(category: category, page: page, pageSize: pageSize);
}
