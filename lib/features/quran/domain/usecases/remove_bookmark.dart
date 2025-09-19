import '../entities/bookmark.dart';
import '../repositories/quran_repository.dart';

class RemoveBookmark {
  final QuranRepository repository;
  RemoveBookmark(this.repository);

  Future<void> call(List<Bookmark> current, String bookmarkId) async {
    final updated = current.where((b) => b.id != bookmarkId).toList();
    return repository.saveBookmarks(updated);
  }
}
