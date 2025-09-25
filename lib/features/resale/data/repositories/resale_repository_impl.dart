import '../../domain/entities/resale_item.dart';
import '../../domain/repositories/resale_repository.dart';
import '../datasources/resale_remote_datasource.dart';
import '../models/resale_models.dart';

class ResaleRepositoryImpl implements ResaleRepository {
  final ResaleRemoteDataSource _remote;
  ResaleRepositoryImpl(this._remote);

  // Session cache
  List<ResaleItem> _cache = [];

  @override
  Future<ResaleItem?> getItemById(String id) async {
    final ResaleDetailDto detail = await _remote.getItemDetail(id);
    final entity = detail.toEntity();
    final idx = _cache.indexWhere((e) => e.id == id);
    if (idx >= 0) {
      _cache[idx] = entity;
    } else {
      _cache.add(entity);
    }
    return entity;
  }

  @override
  Future<List<ResaleItem>> getItems() async {
    // Backend supports status 1 (for sale) and 0 (booked)
    final list1 = await _remote.getItems(status: 1, page: 0, pageSize: 100);
    final list0 = await _remote.getItems(status: 2, page: 0, pageSize: 100);
    _cache = [
      ...list1.map((e) => e.toEntityLite()),
      ...list0.map((e) => e.toEntityLite()),
    ];
    return List<ResaleItem>.from(_cache);
  }

  @override
  Future<void> toggleBooking(String id) async {
    // No API yet: update cache locally for UX
    final idx = _cache.indexWhere((e) => e.id == id);
    if (idx >= 0) {
      final cur = _cache[idx];
      final newStatus = cur.status == ResaleItemStatus.booked
          ? ResaleItemStatus.forSale
          : ResaleItemStatus.booked;
      _cache[idx] = cur.copyWith(status: newStatus);
    }
  }
}
