import '../../domain/entities/quick_link.dart';
import '../../domain/repositories/quick_links_repository.dart';
import '../datasources/quick_links_local_datasource.dart';

class QuickLinksRepositoryImpl implements QuickLinksRepository {
  final QuickLinksLocalDataSource _local;

  QuickLinksRepositoryImpl(this._local);

  @override
  Future<List<QuickLink>> getQuickLinks() => _local.getQuickLinks();
}
