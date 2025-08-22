import '../entities/contact.dart';
import '../repositories/address_book_repository.dart';

class SearchContacts {
  final AddressBookRepository repository;

  SearchContacts(this.repository);

  Future<List<Contact>> call(String query) async {
    if (query.trim().isEmpty) {
      return await repository.getContacts();
    }
    return await repository.searchContacts(query);
  }
}
