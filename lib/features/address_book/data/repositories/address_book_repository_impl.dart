import '../../domain/entities/contact.dart';
import '../../domain/repositories/address_book_repository.dart';
import '../datasources/address_book_local_datasource.dart';

class AddressBookRepositoryImpl implements AddressBookRepository {
  final AddressBookLocalDataSource localDataSource;

  AddressBookRepositoryImpl(this.localDataSource);

  @override
  Future<List<Contact>> getContacts() async {
    return await localDataSource.getContacts();
  }

  @override
  Future<List<Contact>> searchContacts(String query) async {
    return await localDataSource.searchContacts(query);
  }
}
