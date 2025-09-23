import 'ayah.dart';

class SurahEntity {
  final int id;
  final String name; // Arabic name
  final int versesCount; // from surahs.json
  final List<AyahEntity> ayahs;

  SurahEntity({
    required this.id,
    required this.name,
    required this.versesCount,
    required this.ayahs,
  });
}
