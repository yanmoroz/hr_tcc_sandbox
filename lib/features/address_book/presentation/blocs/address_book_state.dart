import 'package:equatable/equatable.dart';
import '../../domain/entities/contact.dart';

abstract class AddressBookState extends Equatable {
  const AddressBookState();

  @override
  List<Object?> get props => [];
}

class AddressBookInitial extends AddressBookState {}

class AddressBookLoading extends AddressBookState {}

class AddressBookLoaded extends AddressBookState {
  final List<Contact> contacts;
  final String searchQuery;
  final int totalCount;

  const AddressBookLoaded({
    required this.contacts,
    this.searchQuery = '',
    required this.totalCount,
  });

  @override
  List<Object?> get props => [contacts, searchQuery, totalCount];

  AddressBookLoaded copyWith({
    List<Contact>? contacts,
    String? searchQuery,
    int? totalCount,
  }) {
    return AddressBookLoaded(
      contacts: contacts ?? this.contacts,
      searchQuery: searchQuery ?? this.searchQuery,
      totalCount: totalCount ?? this.totalCount,
    );
  }
}

class AddressBookError extends AddressBookState {
  final String message;

  const AddressBookError(this.message);

  @override
  List<Object?> get props => [message];
}
