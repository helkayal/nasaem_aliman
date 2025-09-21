import '../entities/juz.dart';
import '../entities/surah.dart';
import '../entities/ayah.dart';

abstract class QuranRepository {
  Future<List<Juz>> getJuzList();
  Future<List<Surah>> getSurahList();
  Future<Surah> getSurah(int id);
  Future<List<Ayah>> getSurahAyahs(int surahId);
  Future<List<Ayah>> getJuzAyahs(int juzId);
  Future<Map<int, List<Ayah>>> groupAyahsByPage(
    List<Ayah> ayahs,
    int surahNumber,
  );
}
