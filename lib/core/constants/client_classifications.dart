class ClientClassifications {
  static const List<String> types = [
    'تاجر دراجات نارية',
    'تاجر قطع غيار',
    'تاجر زيوت',
    'متجر متخصص',
    'تاجر جملة',
    'ورشة / ميكانيكي',
  ];

  static const List<String> employeeRoles = [
    'مهندس',
    'مدير علاقات',
    'فني',
    'محاسب',
    'مدير مبيعات',
    'عامل',
    'أخرى',
  ];

  static const List<String> importanceLevels = ['A', 'B', 'C'];

  static String getImportanceDescription(String level) {
    switch (level) {
      case 'A':
        return 'عميل مهم جداً - أولوية قصوى';
      case 'B':
        return 'عميل مهم - متابعة منتظمة';
      case 'C':
        return 'عميل عادي - متابعة دورية';
      default:
        return '';
    }
  }
}
