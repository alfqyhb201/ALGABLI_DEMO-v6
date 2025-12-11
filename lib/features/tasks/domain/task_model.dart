class Task {
  final String id;
  final String title;
  final String campaignName;
  final String customerName;
  final String location;
  final DateTime dueDate;
  final String status; // 'pending', 'in_progress', 'completed', 'overdue'
  final String priority; // 'high', 'medium', 'low'
  final double progress;

  const Task({
    required this.id,
    required this.title,
    required this.campaignName,
    required this.customerName,
    required this.location,
    required this.dueDate,
    required this.status,
    required this.priority,
    required this.progress,
  });
}

final List<Task> dummyTasks = [
  Task(
    id: '1',
    title: 'زيارة ميدانية - الجبلي ',
    campaignName: 'حملة الترويج الصيفية',
    customerName: 'الجبلي ',
    location: 'شارع الستين، صنعاء',
    dueDate: DateTime.now().add(const Duration(hours: 2)),
    status: 'pending',
    priority: 'high',
    progress: 0.0,
  ),
  Task(
    id: '2',
    title: 'تحديث بيانات -تاجر زيوت',
    campaignName: 'تحديث بيانات كبار العملاء',
    customerName: 'تاجر زيوت',
    location: 'شارع الزبيري، صنعاء',
    dueDate: DateTime.now().add(const Duration(days: 1)),
    status: 'in_progress',
    priority: 'medium',
    progress: 0.5,
  ),
  Task(
    id: '3',
    title: 'متابعة الديون ',
    campaignName: 'تحصيل الديون المتأخرة',
    customerName: 'الجبلي تاجر زيوت',
    location: 'شارع تعز، صنعاء',
    dueDate: DateTime.now().add(const Duration(days: 3)),
    status: 'pending',
    priority: 'high',
    progress: 0.0,
  ),
  Task(
    id: '4',
    title: 'زيارة روتينية ',
    campaignName: 'حملة الترويج الصيفية',
    customerName: 'الجبلي تاجر زيوت',
    location: 'حي السبعين، صنعاء',
    dueDate: DateTime.now().subtract(const Duration(days: 1)),
    status: 'overdue',
    priority: 'high',
    progress: 0.0,
  ),
  Task(
    id: '5',
    title: 'تقييم الخدمة - الجبلي ',
    campaignName: 'تحديث بيانات كبار العملاء',
    customerName: 'الجبلي تاجر زيوت',
    location: 'شارع الثورة، صنعاء',
    dueDate: DateTime.now().add(const Duration(days: 2)),
    status: 'completed',
    priority: 'low',
    progress: 1.0,
  ),
];
