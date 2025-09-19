import 'ayah.dart';

class Surah {
  final int id;
  final String name; // Arabic name
  final int versesCount; // from surahs.json
  final List<Ayah> ayahs;

  Surah({
    required this.id,
    required this.name,
    required this.versesCount,
    required this.ayahs,
  });
}
