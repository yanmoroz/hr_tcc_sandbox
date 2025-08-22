import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../blocs/address_book_bloc.dart';
import '../blocs/address_book_event.dart';
import '../blocs/address_book_state.dart';
import '../widgets/contact_card.dart';
import '../../../../shared/widgets/search_bar.dart';

class AddressBookPage extends StatefulWidget {
  const AddressBookPage({super.key});

  @override
  State<AddressBookPage> createState() => _AddressBookPageState();
}

class _AddressBookPageState extends State<AddressBookPage> {
  late AddressBookBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.instance<AddressBookBloc>();
    _bloc.add(const LoadContacts());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),
            Expanded(
              child: BlocBuilder<AddressBookBloc, AddressBookState>(
                bloc: _bloc,
                builder: (context, state) {
                  if (state is AddressBookLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is AddressBookLoaded) {
                    if (state.contacts.isEmpty &&
                        state.searchQuery.isNotEmpty) {
                      return _buildNoResultsState();
                    }
                    return _buildContactList(state);
                  } else if (state is AddressBookError) {
                    return Center(
                      child: Text(
                        'Ошибка: ${state.message}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                const Text(
                  'Адресная книга',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                BlocBuilder<AddressBookBloc, AddressBookState>(
                  bloc: _bloc,
                  builder: (context, state) {
                    if (state is AddressBookLoaded) {
                      return Text(
                        '${state.totalCount} сотрудников',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return BlocBuilder<AddressBookBloc, AddressBookState>(
      bloc: _bloc,
      builder: (context, state) {
        String searchQuery = '';
        if (state is AddressBookLoaded) {
          searchQuery = state.searchQuery;
        }

        return AppSearchBar(
          initialQuery: searchQuery,
          onSearch: (query) {
            _bloc.add(SearchContactsEvent(query));
          },
          onClear: () {
            _bloc.add(const ClearSearch());
          },
        );
      },
    );
  }

  Widget _buildContactList(AddressBookLoaded state) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: state.contacts.length,
      itemBuilder: (context, index) {
        final contact = state.contacts[index];
        return ContactCard(contact: contact);
      },
    );
  }

  Widget _buildNoResultsState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Таких сотрудников нет',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
