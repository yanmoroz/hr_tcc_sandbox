import '../entities/resale_item.dart';

abstract class ResaleRepository {
  Future<List<ResaleItem>> getItems();
  Future<ResaleItem?> getItemById(String id);
  Future<void> book(String id);
  Future<void> cancelBook(String id);
}
