import '../entities/news.dart';
import '../repositories/news_repository.dart';

class GetNewsCategoriesUseCase {
  final NewsRepository _repository;

  const GetNewsCategoriesUseCase(this._repository);

  Future<List<NewsCategory>> call() => _repository.getCategories();
}
