import '../entities/surah.dart';
import '../repositories/quran_repository.dart';

class GetSurah {
  final QuranRepository repository;
  GetSurah(this.repository);

  Future<SurahEntity> call(int id) {
    return repository.getSurah(id);
  }
}
