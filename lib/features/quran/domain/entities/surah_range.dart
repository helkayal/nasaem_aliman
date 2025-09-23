// domain/entities/surah_range.dart
class SurahRangeEntity {
  final int surahId;
  final String surahName;
  final int startAyah;
  final int endAyah;

  SurahRangeEntity({
    required this.surahId,
    required this.surahName,
    required this.startAyah,
    required this.endAyah,
  });
}
