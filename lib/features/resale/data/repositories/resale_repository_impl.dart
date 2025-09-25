import '../../domain/entities/resale_item.dart';
import '../../domain/repositories/resale_repository.dart';
import '../datasources/resale_remote_datasource.dart';
import '../models/resale_models.dart';

class ResaleRepositoryImpl implements ResaleRepository {
  final ResaleRemoteDataSource _remote;
  ResaleRepositoryImpl(this._remote);

  @override
  Future<ResaleItem?> getItemById(String id) async {
    final ResaleDetailDto detail = await _remote.getItemDetail(id);
    return detail.toEntity();
  }

  @override
  Future<List<ResaleItem>> getItems() async {
    // Backend supports status 1 (for sale) and 2 (booked)
    final list1 = await _remote.getItems(status: 1, page: 0, pageSize: 100);
    final list2 = await _remote.getItems(status: 2, page: 0, pageSize: 100);
    return [
      ...list1.map((e) => e.toEntityLite()),
      ...list2.map((e) => e.toEntityLite()),
    ];
  }

  @override
  Future<void> toggleBooking(String id) async {
    // No API yet; do nothing here. UI handles optimistic updates.
    return;
  }
}
