import '../entities/surah.dart';
import '../repositories/quran_repository.dart';

class GetSurahUseCase {
  final QuranRepository repository;
  GetSurahUseCase(this.repository);

  Future<Surah> call(int id) {
    return repository.getSurah(id);
  }
}
