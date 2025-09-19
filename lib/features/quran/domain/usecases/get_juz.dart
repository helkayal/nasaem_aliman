import '../entities/juz.dart';
import '../repositories/quran_repository.dart';

class GetJuzUseCase {
  final QuranRepository repository;
  GetJuzUseCase(this.repository);

  Future<List<Juz>> call() {
    return repository.getJuz();
  }
}
