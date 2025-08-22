import '../entities/contact.dart';

abstract class AddressBookRepository {
  Future<List<Contact>> getContacts();
  Future<List<Contact>> searchContacts(String query);
}
