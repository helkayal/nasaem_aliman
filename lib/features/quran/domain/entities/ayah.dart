class AyahEntity {
  final int id; // from quran.json
  final int surahId; // link to surah
  final int number; // same as id (or could use order)
  final String text; // "ar" from quran.json

  AyahEntity({
    required this.id,
    required this.surahId,
    required this.number,
    required this.text,
  });
}
