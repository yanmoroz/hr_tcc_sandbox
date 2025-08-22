import 'package:equatable/equatable.dart';

abstract class AddressBookEvent extends Equatable {
  const AddressBookEvent();

  @override
  List<Object?> get props => [];
}

class LoadContacts extends AddressBookEvent {
  const LoadContacts();
}

class SearchContactsEvent extends AddressBookEvent {
  final String query;

  const SearchContactsEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class ClearSearch extends AddressBookEvent {
  const ClearSearch();
}
