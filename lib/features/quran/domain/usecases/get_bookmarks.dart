import '../entities/bookmark.dart';
import '../repositories/quran_repository.dart';

class GetBookmarks {
  final QuranRepository repository;
  GetBookmarks(this.repository);

  Future<List<Bookmark>> call() {
    return repository.getBookmarks();
  }
}
