import 'surah_range.dart';

class JuzEntity {
  final int id;
  final String name;
  final List<SurahRangeEntity> surahRanges;

  JuzEntity({required this.id, required this.name, required this.surahRanges});
}
