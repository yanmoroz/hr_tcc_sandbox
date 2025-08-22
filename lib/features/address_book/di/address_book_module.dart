import 'package:get_it/get_it.dart';
import '../../../app/di/di_module.dart';
import '../data/datasources/address_book_local_datasource.dart';
import '../data/repositories/address_book_repository_impl.dart';
import '../domain/repositories/address_book_repository.dart';
import '../domain/usecases/get_contacts.dart';
import '../domain/usecases/search_contacts.dart';
import '../presentation/blocs/address_book_bloc.dart';

class AddressBookModule extends DiModule {
  @override
  void register(GetIt getIt) {
    // Data sources
    getIt.registerLazySingleton<AddressBookLocalDataSource>(
      () => AddressBookLocalDataSource(),
    );

    // Repositories
    getIt.registerLazySingleton<AddressBookRepository>(
      () => AddressBookRepositoryImpl(getIt<AddressBookLocalDataSource>()),
    );

    // Use cases
    getIt.registerLazySingleton<GetContacts>(
      () => GetContacts(getIt<AddressBookRepository>()),
    );

    getIt.registerLazySingleton<SearchContacts>(
      () => SearchContacts(getIt<AddressBookRepository>()),
    );

    // BLoCs
    getIt.registerFactory<AddressBookBloc>(
      () => AddressBookBloc(
        getContacts: getIt<GetContacts>(),
        searchContacts: getIt<SearchContacts>(),
      ),
    );
  }
}
