import '../entities/contact.dart';
import '../repositories/address_book_repository.dart';

class GetContacts {
  final AddressBookRepository repository;

  GetContacts(this.repository);

  Future<List<Contact>> call() async {
    return await repository.getContacts();
  }
}
