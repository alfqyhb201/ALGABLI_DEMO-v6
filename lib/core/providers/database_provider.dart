import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/app_database.dart';
import 'package:drift/drift.dart';

// Database provider
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(() => database.close());
  return database;
});

// Watch all clients
final watchClientsProvider = StreamProvider<List<Client>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.select(db.clients).watch();
});

// Search clients
final searchClientsProvider = FutureProvider.family<List<Client>, String>((
  ref,
  query,
) async {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.clients)..where((c) => c.name.contains(query))).get();
});

// Watch all cities
final watchCitiesProvider = StreamProvider<List<City>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.select(db.cities).watch();
});

// Watch all classifications
final watchClassificationsProvider = StreamProvider<List<Classification>>((
  ref,
) {
  final db = ref.watch(appDatabaseProvider);
  return db.select(db.classifications).watch();
});
