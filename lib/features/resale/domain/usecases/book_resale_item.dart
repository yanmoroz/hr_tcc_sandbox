import '../repositories/resale_repository.dart';

class BookResaleItemUseCase {
  final ResaleRepository _repository;
  BookResaleItemUseCase(this._repository);

  Future<void> call(String id) => _repository.book(id);
}
