import '../entities/bookmark.dart';
import '../repositories/quran_repository.dart';

class GetBookmarksUseCase {
  final QuranRepository repository;
  GetBookmarksUseCase(this.repository);

  Future<List<Bookmark>> call() {
    return repository.getBookmarks();
  }
}
