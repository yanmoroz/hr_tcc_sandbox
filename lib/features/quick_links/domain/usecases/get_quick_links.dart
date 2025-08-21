import '../entities/quick_link.dart';
import '../repositories/quick_links_repository.dart';

class GetQuickLinksUseCase {
  final QuickLinksRepository repository;
  GetQuickLinksUseCase(this.repository);

  Future<List<QuickLink>> call() => repository.getQuickLinks();
}
