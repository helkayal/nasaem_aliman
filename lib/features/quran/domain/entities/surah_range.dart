// domain/entities/surah_range.dart
class SurahRange {
  final int surahId;
  final String surahName;
  final int startAyah;
  final int endAyah;

  SurahRange({
    required this.surahId,
    required this.surahName,
    required this.startAyah,
    required this.endAyah,
  });
}
