import '../entities/ayah.dart';
import '../repositories/quran_repository.dart';

class GetJuzAyahs {
  final QuranRepository repository;

  GetJuzAyahs(this.repository);

  Future<List<AyahEntity>> call(int juzId) async {
    return await repository.getJuzAyahs(juzId);
  }
}
