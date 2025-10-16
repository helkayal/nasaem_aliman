import '../repositories/quran_repository.dart';

class GetPageForJuzSurah {
  final QuranRepository repository;
  GetPageForJuzSurah(this.repository);

  Future<int> call(int juzId, int surahId, int startAyah) {
    return repository.getPageForJuzSurah(juzId, surahId, startAyah);
  }
}
