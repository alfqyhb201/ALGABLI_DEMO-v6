import 'package:drift/drift.dart';

// JSON Converter for lists
class JsonConverter extends TypeConverter<List<String>, String> {
  const JsonConverter();

  @override
  List<String> fromSql(String fromDb) {
    if (fromDb.isEmpty) return [];
    return (fromDb.split(','));
  }

  @override
  String toSql(List<String> value) {
    return value.join(',');
  }
}

// --- Core Tables ---

// Clients Table (Matches MySQL 'clients')
class Clients extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get remoteId => integer().nullable()(); // ID from MySQL
  TextColumn get name => text()();
  TextColumn get phone => text().map(const JsonConverter()).nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get category => text().nullable()();
  IntColumn get agentId => integer().nullable()();
  IntColumn get branchId => integer().nullable()();

  // Extra fields for UI/App logic
  TextColumn get address => text().nullable()();
  TextColumn get gpsLocation => text().nullable()();
  TextColumn get images => text().map(const JsonConverter()).nullable()();
  TextColumn get profileImage => text().nullable()();
  TextColumn get importance => text().nullable()(); // A, B, C classification

  // New fields for Customer Form alignment
  TextColumn get province => text().nullable()();
  TextColumn get district => text().nullable()();
  TextColumn get notes => text().nullable()();
  BoolColumn get isAgent => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastVisit => dateTime().nullable()();
  TextColumn get loyaltyLevel => text().nullable()();

  BoolColumn get isDraft => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

// Campaigns Table (Matches MySQL 'campaigns')
class Campaigns extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get campaignType => text()(); // email, sms, etc.
  TextColumn get status => text().withDefault(const Constant('draft'))();
  DateTimeColumn get startDate => dateTime().nullable()();
  DateTimeColumn get endDate => dateTime().nullable()();
  TextColumn get objective => text().nullable()();
  RealColumn get budget => real().withDefault(const Constant(0.0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

// Tasks Table (Matches MySQL 'tasks')
class Tasks extends Table {
  TextColumn get id => text()(); // UUID
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('todo'))();
  TextColumn get priority => text().withDefault(const Constant('medium'))();
  DateTimeColumn get startAt => dateTime().nullable()();
  DateTimeColumn get dueAt => dateTime().nullable()();
  TextColumn get location => text().nullable()();
  TextColumn get syncStatus => text().withDefault(
    const Constant('synced'),
  )(); // pending, synced, conflict
  IntColumn get progressPercentage =>
      integer().withDefault(const Constant(0))();

  // Relationships
  IntColumn get campaignId => integer().nullable()();
  IntColumn get clientId => integer().nullable()();
  IntColumn get assigneeId => integer().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// Field Reports Table (Matches MySQL 'field_reports')
class FieldReports extends Table {
  TextColumn get id => text()(); // UUID
  TextColumn get notes => text().nullable()();
  TextColumn get photos => text().map(const JsonConverter()).nullable()();
  TextColumn get location => text().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  TextColumn get taskId => text().nullable()();
  IntColumn get reporterId => integer().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// SubTasks Table (Checklist items)
class SubTasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get taskId => text().references(Tasks, #id)();
  TextColumn get title => text()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

// --- Inventory Tables ---

// Ad Assets Table (Matches MySQL 'ad_assets')
class AdAssets extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get assetCode => text().nullable()();
  TextColumn get name => text()();
  TextColumn get type => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('available'))();
  IntColumn get quantity => integer().withDefault(const Constant(0))();
  IntColumn get usedQuantity => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

// --- Sync Tables ---

// Sync Queue Table (Matches MySQL 'sync_queue' logic)
class SyncQueue extends Table {
  TextColumn get id => text()(); // UUID
  TextColumn get entity => text()(); // 'clients', 'tasks', etc.
  TextColumn get operation => text()(); // 'insert', 'update', 'delete'
  TextColumn get payload => text().nullable()(); // JSON payload
  TextColumn get status => text().withDefault(const Constant('pending'))();
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// --- New Tables for Full Sync ---

// Client Employees Table
@DataClassName('ClientEmployee')
class ClientEmployees extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get remoteId => integer().nullable()();
  IntColumn get clientId => integer()(); // Foreign key to Clients
  IntColumn get previousClientId => integer().nullable()(); // History
  TextColumn get name => text()();
  TextColumn get phone => text().nullable()();
  TextColumn get role => text().nullable()(); // Manager, Accountant, etc.
  BoolColumn get isDecisionMaker =>
      boolean().withDefault(const Constant(false))();
  TextColumn get notes => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

// Branches Table
@DataClassName('Branch')
class Branches extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get remoteId => integer().nullable()();
  TextColumn get name => text()();
  TextColumn get address => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get managerName => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

// Cities/Locations Table (for dynamic dropdowns)
@DataClassName('City')
class Cities extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get remoteId => integer().nullable()();
  TextColumn get name => text()();
  TextColumn get governorate => text().nullable()(); // Parent region

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

// Classifications Table (for dynamic dropdowns)
@DataClassName('Classification')
class Classifications extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get remoteId => integer().nullable()();
  TextColumn get name => text()();
  TextColumn get type => text().nullable()(); // Client, Task, etc.

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
