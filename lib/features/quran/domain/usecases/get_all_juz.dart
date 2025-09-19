import '../entities/juz.dart';
import '../repositories/quran_repository.dart';

class GetAllJuz {
  final QuranRepository repository;

  GetAllJuz(this.repository);

  Future<List<Juz>> call() async {
    return await repository.getJuzList();
  }
}
