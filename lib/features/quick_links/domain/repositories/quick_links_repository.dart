import '../entities/quick_link.dart';

abstract class QuickLinksRepository {
  Future<List<QuickLink>> getQuickLinks();
}
