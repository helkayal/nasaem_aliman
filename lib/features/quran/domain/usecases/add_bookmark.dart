import '../entities/bookmark.dart';
import '../repositories/quran_repository.dart';

class AddBookmark {
  final QuranRepository repository;
  AddBookmark(this.repository);

  Future<void> call(List<Bookmark> current, Bookmark newBookmark) async {
    final updated = List<Bookmark>.from(current)..add(newBookmark);
    return repository.saveBookmarks(updated);
  }
}
