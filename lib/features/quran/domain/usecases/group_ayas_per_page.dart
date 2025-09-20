import '../../data/models/ayah_model.dart';
import '../repositories/quran_repository.dart';

class GroupAyahsByPage {
  final QuranRepository repository;
  GroupAyahsByPage(this.repository);

  Future<Map<int, List<AyahModel>>> call(
    List<AyahModel> ayahs,
    int surahNumber,
  ) async {
    return await repository.groupAyahsByPage(ayahs, surahNumber);
  }
}
