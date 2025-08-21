import 'package:get_it/get_it.dart';

abstract class DiModule {
  void register(GetIt getIt);

  Future<void> dispose(GetIt getIt) async {}
}
