import 'package:string_similarity/string_similarity.dart';

class DuplicateChecker {
  /// فحص تشابه الأسماء
  /// يرجع true إذا كان التشابه أكثر من 80%
  static bool isSimilar(String name1, String name2, {double threshold = 0.8}) {
    final similarity = name1.similarityTo(name2);
    return similarity >= threshold;
  }

  /// البحث عن أسماء مشابهة في قائمة
  static List<SimilarResult> findSimilar(
    String searchName,
    List<String> existingNames, {
    double threshold = 0.7,
  }) {
    final results = <SimilarResult>[];

    for (var i = 0; i < existingNames.length; i++) {
      final similarity = searchName.similarityTo(existingNames[i]);
      if (similarity >= threshold) {
        results.add(SimilarResult(
          name: existingNames[i],
          similarity: similarity,
          index: i,
        ));
      }
    }

    // ترتيب النتائج حسب نسبة التشابه (الأعلى أولاً)
    results.sort((a, b) => b.similarity.compareTo(a.similarity));
    return results;
  }

  /// فحص التكرار التام
  static bool isDuplicate(String name, List<String> existingNames) {
    final normalizedName = _normalize(name);
    return existingNames.any((existing) => _normalize(existing) == normalizedName);
  }

  /// تطبيع النص (إزالة المسافات الزائدة وتوحيد الحالة)
  static String _normalize(String text) {
    return text.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
  }

  /// الحصول على أفضل تطابق
  static SimilarResult? getBestMatch(
    String searchName,
    List<String> existingNames,
  ) {
    if (existingNames.isEmpty) return null;

    final bestMatch = searchName.bestMatch(existingNames);
    return SimilarResult(
      name: bestMatch.bestMatch.target!,
      similarity: bestMatch.bestMatch.rating!,
      index: bestMatch.bestMatchIndex,
    );
  }
}

class SimilarResult {
  final String name;
  final double similarity;
  final int index;

  SimilarResult({
    required this.name,
    required this.similarity,
    required this.index,
  });

  /// نسبة التشابه كنسبة مئوية
  int get similarityPercentage => (similarity * 100).round();

  /// هل النتيجة مطابقة بشكل كبير؟
  bool get isHighMatch => similarity >= 0.9;

  /// هل النتيجة مطابقة بشكل متوسط؟
  bool get isMediumMatch => similarity >= 0.7 && similarity < 0.9;
}
