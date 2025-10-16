import 'package:equatable/equatable.dart';
import 'ayah.dart';

class QuranPageEntity extends Equatable {
  final int pageNumber;
  final List<AyahEntity> ayahs;
  final Set<int> surahIds; // Which surahs appear on this page

  const QuranPageEntity({
    required this.pageNumber,
    required this.ayahs,
    required this.surahIds,
  });

  @override
  List<Object?> get props => [pageNumber, ayahs, surahIds];

  // Helper methods
  bool containsSurah(int surahId) => surahIds.contains(surahId);

  int get ayahCount => ayahs.length;

  bool get isEmpty => ayahs.isEmpty;

  // Get the main surah (the one with most ayahs on this page)
  int? get primarySurahId {
    if (surahIds.isEmpty) return null;
    if (surahIds.length == 1) return surahIds.first;

    // Find surah with most ayahs on this page
    final surahAyahCounts = <int, int>{};
    for (final ayah in ayahs) {
      surahAyahCounts[ayah.surahId] = (surahAyahCounts[ayah.surahId] ?? 0) + 1;
    }

    return surahAyahCounts.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }
}
