import '../entities/surah.dart';
import '../repositories/quran_repository.dart';

class GetAllSurahsUseCase {
  final QuranRepository repository;
  GetAllSurahsUseCase(this.repository);

  Future<List<Surah>> call() {
    return repository.getAllSurahs();
  }
}
