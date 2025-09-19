import '../entities/bookmark.dart';
import '../repositories/quran_repository.dart';

class GetLastReadUseCase {
  final QuranRepository repository;
  GetLastReadUseCase(this.repository);

  Future<Bookmark?> call() async {
    final bookmarks = await repository.getBookmarks();
    try {
      return bookmarks.firstWhere((b) => b.isLastRead);
    } catch (_) {
      return null;
    }
  }
}
