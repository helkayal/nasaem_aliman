import '../entities/juz.dart';
import '../repositories/quran_repository.dart';

class GetAllJuz {
  final QuranRepository repository;

  GetAllJuz(this.repository);

  Future<List<JuzEntity>> call() async {
    return await repository.getJuzList();
  }
}
