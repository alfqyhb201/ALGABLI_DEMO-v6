class Campaign {
  final String id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final double progress;
  final String status; // 'active', 'completed', 'pending'
  final int assignedTasksCount;
  final int completedTasksCount;

  const Campaign({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.progress,
    required this.status,
    required this.assignedTasksCount,
    required this.completedTasksCount,
  });
}

final List<Campaign> dummyCampaigns = [
  Campaign(
    id: '1',
    title: 'حملة الترويج الصيفية',
    description: 'زيارة المحلات التجارية في منطقة حدة لتوزيع البروشورات والتعريف بالمنتجات الجديدة.',
    startDate: DateTime.now().subtract(const Duration(days: 2)),
    endDate: DateTime.now().add(const Duration(days: 10)),
    progress: 0.4,
    status: 'active',
    assignedTasksCount: 30,
    completedTasksCount: 12,
  ),
  Campaign(
    id: '2',
    title: 'تحديث بيانات كبار العملاء',
    description: 'زيارة كبار العملاء لتحديث بيانات الاتصال والتأكد من رضاهم عن الخدمة.',
    startDate: DateTime.now().subtract(const Duration(days: 5)),
    endDate: DateTime.now().add(const Duration(days: 5)),
    progress: 0.75,
    status: 'active',
    assignedTasksCount: 20,
    completedTasksCount: 15,
  ),
  Campaign(
    id: '3',
    title: 'تحصيل الديون المتأخرة',
    description: 'متابعة العملاء المتأخرين عن السداد لأكثر من 60 يوم.',
    startDate: DateTime.now(),
    endDate: DateTime.now().add(const Duration(days: 15)),
    progress: 0.0,
    status: 'pending',
    assignedTasksCount: 10,
    completedTasksCount: 0,
  ),
];
