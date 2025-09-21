import '../entities/ayah.dart';
import '../repositories/quran_repository.dart';

class GroupAyahsByPage {
  final QuranRepository repository;
  GroupAyahsByPage(this.repository);

  Future<Map<int, List<Ayah>>> call(List<Ayah> ayahs, int surahNumber) async {
    return await repository.groupAyahsByPage(ayahs, surahNumber);
  }
}
