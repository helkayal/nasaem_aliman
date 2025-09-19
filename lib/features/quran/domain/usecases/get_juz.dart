import '../entities/juz.dart';
import '../repositories/quran_repository.dart';

class GetJuz {
  final QuranRepository repository;
  GetJuz(this.repository);

  Future<List<Juz>> call() {
    return repository.getJuz();
  }
}
