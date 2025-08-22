import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/contact.dart';
import '../../domain/usecases/get_contacts.dart';
import '../../domain/usecases/search_contacts.dart';
import 'address_book_event.dart';
import 'address_book_state.dart';

class AddressBookBloc extends Bloc<AddressBookEvent, AddressBookState> {
  final GetContacts getContacts;
  final SearchContacts searchContacts;

  AddressBookBloc({required this.getContacts, required this.searchContacts})
    : super(AddressBookInitial()) {
    on<LoadContacts>(_onLoadContacts);
    on<SearchContactsEvent>(_onSearchContacts);
    on<ClearSearch>(_onClearSearch);
  }

  Future<void> _onLoadContacts(
    LoadContacts event,
    Emitter<AddressBookState> emit,
  ) async {
    emit(AddressBookLoading());
    try {
      final contacts = await getContacts();
      emit(AddressBookLoaded(contacts: contacts, totalCount: contacts.length));
    } catch (e) {
      emit(AddressBookError(e.toString()));
    }
  }

  Future<void> _onSearchContacts(
    SearchContactsEvent event,
    Emitter<AddressBookState> emit,
  ) async {
    emit(AddressBookLoading());
    try {
      final contacts = await searchContacts(event.query);
      final currentState = state is AddressBookLoaded
          ? (state as AddressBookLoaded).totalCount
          : contacts.length;
      emit(
        AddressBookLoaded(
          contacts: contacts,
          searchQuery: event.query,
          totalCount: currentState,
        ),
      );
    } catch (e) {
      emit(AddressBookError(e.toString()));
    }
  }

  Future<void> _onClearSearch(
    ClearSearch event,
    Emitter<AddressBookState> emit,
  ) async {
    emit(AddressBookLoading());
    try {
      final contacts = await getContacts();
      emit(
        AddressBookLoaded(
          contacts: contacts,
          searchQuery: '',
          totalCount: contacts.length,
        ),
      );
    } catch (e) {
      emit(AddressBookError(e.toString()));
    }
  }
}
