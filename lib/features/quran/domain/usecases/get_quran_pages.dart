import '../entities/quran_page.dart';
import '../repositories/quran_repository.dart';

class GetQuranPages {
  final QuranRepository repository;
  GetQuranPages(this.repository);

  Future<List<QuranPageEntity>> call() {
    return repository.getAllQuranPages();
  }
}
