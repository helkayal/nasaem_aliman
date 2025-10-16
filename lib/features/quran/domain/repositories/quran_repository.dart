import '../entities/juz.dart';
import '../entities/surah.dart';
import '../entities/ayah.dart';
import '../entities/quran_page.dart';

abstract class QuranRepository {
  Future<List<JuzEntity>> getJuzList();
  Future<List<SurahEntity>> getSurahList();
  Future<SurahEntity> getSurah(int id);
  Future<List<AyahEntity>> getSurahAyahs(int surahId);
  Future<List<AyahEntity>> getJuzAyahs(int juzId);
  Future<Map<int, List<AyahEntity>>> groupAyahsByPage(
    List<AyahEntity> ayahs,
    int surahNumber,
  );

  // New page-based methods
  Future<List<QuranPageEntity>> getAllQuranPages();
  Future<int> getPageForSurah(int surahId);
  Future<int> getPageForJuzSurah(int juzId, int surahId, int startAyah);
}
