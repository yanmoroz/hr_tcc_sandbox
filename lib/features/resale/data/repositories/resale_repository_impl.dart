import '../../domain/entities/resale_item.dart';
import '../../domain/repositories/resale_repository.dart';
import '../datasources/resale_local_datasource.dart';

class ResaleRepositoryImpl implements ResaleRepository {
  final ResaleLocalDataSource _local;
  ResaleRepositoryImpl(this._local);

  @override
  Future<ResaleItem?> getItemById(String id) => _local.getItemById(id);

  @override
  Future<List<ResaleItem>> getItems() => _local.getItems();

  @override
  Future<void> toggleBooking(String id) => _local.toggleBooking(id);
}
