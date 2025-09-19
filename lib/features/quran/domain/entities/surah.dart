import 'ayah.dart';

class Surah {
  final int id;
  final String name;
  final String nameEn;
  final String nameTranslation;
  final bool bismillahPre;
  final int words;
  final int letters;
  final List<int> pages;
  final String type;
  final List<Ayah> ayahs;

  Surah({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.nameTranslation,
    required this.bismillahPre,
    required this.words,
    required this.letters,
    required this.pages,
    required this.type,
    required this.ayahs,
  });
}
