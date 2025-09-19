import '../entities/surah.dart';
import '../repositories/quran_repository.dart';

class GetAllSurahs {
  final QuranRepository repository;
  GetAllSurahs(this.repository);

  Future<List<Surah>> call() {
    return repository.getSurahList();
  }
}
