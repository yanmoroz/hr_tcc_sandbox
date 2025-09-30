import '../repositories/resale_repository.dart';

class CancelBookResaleItemUseCase {
  final ResaleRepository _repository;
  CancelBookResaleItemUseCase(this._repository);

  Future<void> call(String id) => _repository.cancelBook(id);
}
