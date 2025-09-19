class Juz {
  final int number;
  final String name;
  final List<JuzSurah> surahs;

  Juz({required this.number, required this.name, required this.surahs});
}

class JuzSurah {
  final int sura;
  final String suraName;
  final List<int> aya;

  JuzSurah({required this.sura, required this.suraName, required this.aya});
}
