import '../entities/juz.dart';
import '../repositories/quran_repository.dart';

class GetAllJuzUseCase {
  final QuranRepository repository;
  GetAllJuzUseCase(this.repository);

  Future<List<Juz>> call() {
    return repository.getAllJuz();
  }
}
