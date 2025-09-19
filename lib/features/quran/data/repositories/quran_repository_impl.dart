import '../../domain/entities/bookmark.dart';
import '../../domain/entities/juz.dart';
import '../../domain/entities/surah.dart';
import '../../domain/repositories/quran_repository.dart';
import '../datasources/quran_local_datasource.dart';
import '../models/bookmark_model.dart';

class QuranRepositoryImpl implements QuranRepository {
  final QuranLocalDataSource localDataSource;
  QuranRepositoryImpl(this.localDataSource);

  @override
  Future<List<Surah>> getAllSurahs() => localDataSource.getAllSurahs();

  @override
  Future<Surah> getSurah(int id) => localDataSource.getSurah(id);

  @override
  Future<List<Juz>> getAllJuz() => localDataSource.getAllJuz();

  @override
  Future<List<Juz>> getJuz() async {
    return await localDataSource.getJuz();
  }

  @override
  Future<List<Bookmark>> getBookmarks() async {
    final models = await localDataSource.getBookmarks();
    return models
        .map(
          (m) => Bookmark(
            id: m.id,
            surahId: m.surahId,
            ayahId: m.ayahId,
            name: m.name,
            color: m.color,
            isLastRead: m.isLastRead,
          ),
        )
        .toList();
  }

  @override
  Future<void> saveBookmarks(List<Bookmark> bookmarks) {
    final models = bookmarks
        .map(
          (b) => BookmarkModel(
            id: b.id,
            surahId: b.surahId,
            ayahId: b.ayahId,
            name: b.name,
            color: b.color,
            isLastRead: b.isLastRead,
          ),
        )
        .toList();

    return localDataSource.saveBookmarks(models);
  }
}
