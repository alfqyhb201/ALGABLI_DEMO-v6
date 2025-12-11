import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Clients,
    Campaigns,
    Tasks,
    FieldReports,
    AdAssets,
    SyncQueue,
    ClientEmployees,
    Branches,
    Cities,
    Classifications,
    SubTasks,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 5; // Incremented version

  // --- Clients Operations ---
  Future<List<Client>> getAllClients() => select(clients).get();

  Future<List<Client>> getAgents() =>
      (select(clients)..where((c) => c.category.equals('وكيل'))).get();

  Future<Client> getClient(int id) =>
      (select(clients)..where((c) => c.id.equals(id))).getSingle();

  Future<int> insertClient(ClientsCompanion client) =>
      into(clients).insert(client);

  Future<int> updateClient(ClientsCompanion client) => (update(
    clients,
  )..where((c) => c.id.equals(client.id.value))).write(client);

  Future<int> deleteClient(int id) =>
      (delete(clients)..where((c) => c.id.equals(id))).go();

  // --- Client Employees Operations ---
  Future<List<ClientEmployee>> getClientEmployees(int clientId) => (select(
    clientEmployees,
  )..where((e) => e.clientId.equals(clientId))).get();

  Future<int> insertClientEmployee(ClientEmployeesCompanion employee) =>
      into(clientEmployees).insert(employee);

  // --- Branches Operations ---
  Future<List<Branch>> getAllBranches() => select(branches).get();

  Future<int> insertBranch(BranchesCompanion branch) =>
      into(branches).insert(branch);

  // --- Cities Operations ---
  Future<List<City>> getAllCities() => select(cities).get();

  Future<int> insertCity(CitiesCompanion city) => into(cities).insert(city);

  // --- Classifications Operations ---
  Future<List<Classification>> getAllClassifications() =>
      select(classifications).get();

  Future<int> insertClassification(ClassificationsCompanion classification) =>
      into(classifications).insert(classification);

  // --- Tasks Operations ---
  Future<List<Task>> getAllTasks() => select(tasks).get();

  Future<Task> getTask(String id) =>
      (select(tasks)..where((t) => t.id.equals(id))).getSingle();

  Future<int> insertTask(TasksCompanion task) => into(tasks).insert(task);

  Future<bool> updateTask(Task task) => update(tasks).replace(task);

  Future<int> deleteTask(String id) =>
      (delete(tasks)..where((t) => t.id.equals(id))).go();

  // --- SubTasks Operations ---
  Future<List<SubTask>> getSubTasks(String taskId) =>
      (select(subTasks)..where((s) => s.taskId.equals(taskId))).get();

  Future<int> insertSubTask(SubTasksCompanion subTask) =>
      into(subTasks).insert(subTask);

  Future<bool> updateSubTask(SubTask subTask) =>
      update(subTasks).replace(subTask);

  Future<int> deleteSubTask(int id) =>
      (delete(subTasks)..where((s) => s.id.equals(id))).go();

  // --- Campaigns Operations ---
  Future<List<Campaign>> getAllCampaigns() => select(campaigns).get();

  Future<int> insertCampaign(CampaignsCompanion campaign) =>
      into(campaigns).insert(campaign);

  Future<bool> updateCampaign(Campaign campaign) =>
      update(campaigns).replace(campaign);

  Future<int> deleteCampaign(int id) =>
      (delete(campaigns)..where((c) => c.id.equals(id))).go();

  // --- Sync Queue Operations ---
  Future<List<SyncQueueData>> getPendingSyncItems() =>
      (select(syncQueue)..where((s) => s.status.equals('pending'))).get();

  Future<int> addToSyncQueue(SyncQueueCompanion item) =>
      into(syncQueue).insert(item);

  Future<int> updateSyncStatus(String id, String status) =>
      (update(syncQueue)..where((s) => s.id.equals(id))).write(
        SyncQueueCompanion(status: Value(status)),
      );

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 5) {
          // Assuming profileImage and images were added recently.
          // We can try to add them if they don't exist, or just recreate the table in dev.
          // For a robust app, we'd use m.addColumn.
          // Since we are in dev and want to ensure consistency:
          await m.addColumn(clients, clients.profileImage);
          await m.addColumn(clients, clients.images);
        }
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'aljabali_erp_v2.sqlite'));
    return NativeDatabase(file);
  });
}
