import '../entities/resale_item.dart';
import '../repositories/resale_repository.dart';

class GetResaleItemsUseCase {
  final ResaleRepository _repository;
  GetResaleItemsUseCase(this._repository);

  Future<List<ResaleItem>> call() => _repository.getItems();
}
