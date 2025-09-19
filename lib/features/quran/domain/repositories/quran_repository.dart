import '../entities/surah.dart';
import '../entities/juz.dart';
import '../entities/bookmark.dart';

abstract class QuranRepository {
  Future<List<Surah>> getAllSurahs();
  Future<Surah> getSurah(int id);
  Future<List<Juz>> getAllJuz();
  Future<List<Juz>> getJuz();
  Future<List<Bookmark>> getBookmarks();
  Future<void> saveBookmarks(List<Bookmark> bookmarks);
}
