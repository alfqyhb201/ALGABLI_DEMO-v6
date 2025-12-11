import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/app_database.dart';
import 'package:drift/drift.dart';
import 'database_provider.dart';
import '../services/auth_service.dart';

// Tasks Providers
final allTasksProvider = StreamProvider<List<Task>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.select(db.tasks).watch();
});

final myTasksProvider = StreamProvider<List<Task>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final currentUser = ref.watch(currentUserProvider);

  if (currentUser == null) {
    return Stream.value([]);
  }

  // Assuming 'id' is the key for user ID in the user map
  final userId = currentUser['id'];
  if (userId == null) {
    return Stream.value([]);
  }

  // Handle both int and string ID if necessary, but DB expects int
  final int? parsedId = userId is int
      ? userId
      : int.tryParse(userId.toString());

  if (parsedId == null) return Stream.value([]);

  return (db.select(
    db.tasks,
  )..where((t) => t.assigneeId.equals(parsedId))).watch();
});

final taskByIdProvider = StreamProvider.family<Task, String>((ref, id) {
  final db = ref.watch(appDatabaseProvider);
  return db
      .select(db.tasks)
      .watch()
      .map((tasks) => tasks.firstWhere((t) => t.id == id));
});

final tasksByCampaignProvider = StreamProvider.family<List<Task>, int>((
  ref,
  campaignId,
) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(
    db.tasks,
  )..where((t) => t.campaignId.equals(campaignId))).watch();
});

// Campaigns Providers
final allCampaignsProvider = StreamProvider<List<Campaign>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.select(db.campaigns).watch();
});

final campaignByIdProvider = StreamProvider.family<Campaign, int>((ref, id) {
  final db = ref.watch(appDatabaseProvider);
  return db
      .select(db.campaigns)
      .watch()
      .map((c) => c.firstWhere((cmp) => cmp.id == id));
});

// SubTasks Provider
final subTasksProvider = StreamProvider.family<List<SubTask>, String>((
  ref,
  taskId,
) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(
    db.subTasks,
  )..where((s) => s.taskId.equals(taskId))).watch();
});

// Controllers
final tasksControllerProvider = Provider(
  (ref) => TasksController(ref.watch(appDatabaseProvider)),
);

class TasksController {
  final AppDatabase _db;

  TasksController(this._db);

  Future<void> addTask(TasksCompanion task) => _db.insertTask(task);

  Future<void> updateTask(Task task) => _db.updateTask(task);

  Future<void> deleteTask(String id) => _db.deleteTask(id);

  Future<void> updateTaskStatus(Task task, String status) {
    return _db.updateTask(task.copyWith(status: status));
  }

  Future<void> updateTaskProgress(Task task, int progress) {
    return _db.updateTask(task.copyWith(progressPercentage: progress));
  }

  // SubTasks Methods
  Future<void> addSubTask(SubTasksCompanion subTask) =>
      _db.insertSubTask(subTask);

  Future<void> toggleSubTask(SubTask subTask) async {
    final newStatus = !subTask.isCompleted;
    await _db.updateSubTask(subTask.copyWith(isCompleted: newStatus));
    await _updateParentTaskProgress(subTask.taskId);
  }

  Future<void> deleteSubTask(int id, String taskId) async {
    await _db.deleteSubTask(id);
    await _updateParentTaskProgress(taskId);
  }

  Future<void> _updateParentTaskProgress(String taskId) async {
    final subTasks = await _db.getSubTasks(taskId);
    if (subTasks.isEmpty) return;

    final completedCount = subTasks.where((s) => s.isCompleted).length;
    final progress = (completedCount / subTasks.length * 100).round();

    final task = await _db.getTask(taskId);

    String newStatus = task.status;
    if (progress == 100) {
      newStatus = 'completed';
    } else if (progress > 0 && task.status == 'todo') {
      newStatus = 'in_progress';
    } else if (progress < 100 && task.status == 'completed') {
      newStatus = 'in_progress';
    }

    await _db.updateTask(
      task.copyWith(progressPercentage: progress, status: newStatus),
    );
  }
}

final campaignsControllerProvider = Provider(
  (ref) => CampaignsController(ref.watch(appDatabaseProvider)),
);

class CampaignsController {
  final AppDatabase _db;

  CampaignsController(this._db);

  Future<void> addCampaign(CampaignsCompanion campaign) =>
      _db.insertCampaign(campaign);

  Future<void> updateCampaign(Campaign campaign) =>
      _db.updateCampaign(campaign);

  Future<void> deleteCampaign(int id) => _db.deleteCampaign(id);
}
