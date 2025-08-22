import '../entities/resale_item.dart';
import '../repositories/resale_repository.dart';

class GetResaleItemDetailUseCase {
  final ResaleRepository _repository;
  GetResaleItemDetailUseCase(this._repository);

  Future<ResaleItem?> call(String id) => _repository.getItemById(id);
}
