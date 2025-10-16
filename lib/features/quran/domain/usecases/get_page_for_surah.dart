import '../repositories/quran_repository.dart';

class GetPageForSurah {
  final QuranRepository repository;
  GetPageForSurah(this.repository);

  Future<int> call(int surahId) {
    return repository.getPageForSurah(surahId);
  }
}
