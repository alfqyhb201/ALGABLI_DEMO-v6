import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/database_provider.dart';

class ReportsData {
  final int totalClients;
  final int newClients;
  final int totalReports;
  final double completionRate; // 0.0 to 1.0
  final List<int> weeklyVisits; // Last 7 days
  final Map<String, int> clientsByCategory;

  ReportsData({
    required this.totalClients,
    required this.newClients,
    required this.totalReports,
    required this.completionRate,
    required this.weeklyVisits,
    required this.clientsByCategory,
  });
}

final reportsProvider = FutureProvider<ReportsData>((ref) async {
  final db = ref.watch(appDatabaseProvider);

  // 1. Total Clients
  final totalClientsExp = db.clients.id.count();
  final totalClients =
      await (db.selectOnly(db.clients)..addColumns([totalClientsExp]))
          .map((row) => row.read(totalClientsExp) ?? 0)
          .getSingle();

  // 2. New Clients (This Month)
  final now = DateTime.now();
  final startOfMonth = DateTime(now.year, now.month, 1);
  final newClientsExp = db.clients.id.count();
  final newClients =
      await (db.selectOnly(db.clients)
            ..addColumns([newClientsExp])
            ..where(db.clients.createdAt.isBiggerOrEqualValue(startOfMonth)))
          .map((row) => row.read(newClientsExp) ?? 0)
          .getSingle();

  // 3. Total Reports
  final totalReportsExp = db.fieldReports.id.count();
  final totalReports =
      await (db.selectOnly(db.fieldReports)..addColumns([totalReportsExp]))
          .map((row) => row.read(totalReportsExp) ?? 0)
          .getSingle();

  // 4. Completion Rate (Tasks)
  // If no tasks, default to 0.84 (dummy) or 0.0
  final totalTasksExp = db.tasks.id.count();
  final completedTasksExp = db.tasks.id.count();

  final totalTasks =
      await (db.selectOnly(db.tasks)..addColumns([totalTasksExp]))
          .map((row) => row.read(totalTasksExp) ?? 0)
          .getSingle();

  double completionRate = 0.0;
  if (totalTasks > 0) {
    final completedTasks =
        await (db.selectOnly(db.tasks)
              ..addColumns([completedTasksExp])
              ..where(db.tasks.status.equals('completed')))
            .map((row) => row.read(completedTasksExp) ?? 0)
            .getSingle();
    completionRate = completedTasks / totalTasks;
  } else {
    completionRate = 0.0; // No tasks yet
  }

  // 5. Weekly Visits (Last 7 days based on FieldReports)
  // This is a bit complex in pure SQL with Drift without raw queries for grouping by date.
  // We'll fetch last 7 days reports and aggregate in Dart for simplicity.
  final sevenDaysAgo = now.subtract(const Duration(days: 6));
  final recentReports = await (db.select(
    db.fieldReports,
  )..where((t) => t.createdAt.isBiggerOrEqualValue(sevenDaysAgo))).get();

  List<int> weeklyVisits = List.filled(7, 0);
  // Map 0 -> 6 days ago, 6 -> today? Or 0 -> Sat, 6 -> Fri?
  // The UI expects Sat..Fri. Let's align with the UI's expectation or update UI.
  // The UI shows Sat, Sun, Mon... Fri.
  // Let's just return counts for the last 7 days relative to today for now,
  // and we can map them to days in the UI.
  // Actually, to match the UI "Sat...Fri", we need to know which day is today.
  // Let's simplify: Index 0 = Today - 6 days, Index 6 = Today.

  for (var report in recentReports) {
    final diff = now.difference(report.createdAt).inDays;
    if (diff >= 0 && diff < 7) {
      // 0 days ago -> index 6
      // 6 days ago -> index 0
      weeklyVisits[6 - diff]++;
    }
  }

  // 6. Clients by Category
  final clients = await db.select(db.clients).get();
  final Map<String, int> clientsByCategory = {};
  for (var client in clients) {
    final cat = client.category ?? 'Uncategorized';
    clientsByCategory[cat] = (clientsByCategory[cat] ?? 0) + 1;
  }

  return ReportsData(
    totalClients: totalClients,
    newClients: newClients,
    totalReports: totalReports,
    completionRate: completionRate,
    weeklyVisits: weeklyVisits,
    clientsByCategory: clientsByCategory,
  );
});
