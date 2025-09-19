import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasaem_aliman/features/quran/domain/entities/bookmark.dart';
import 'package:nasaem_aliman/features/quran/domain/entities/surah.dart';
import 'package:nasaem_aliman/features/quran/domain/usecases/add_bookmark.dart';
// import 'package:nasaem_aliman/features/quran/domain/usecases/get_all_juz.dart';
import 'package:nasaem_aliman/features/quran/domain/usecases/get_all_surahs.dart';
import 'package:nasaem_aliman/features/quran/domain/usecases/get_bookmarks.dart';
import 'package:nasaem_aliman/features/quran/domain/usecases/get_juz.dart';
import 'package:nasaem_aliman/features/quran/domain/usecases/get_last_read.dart';
import 'package:nasaem_aliman/features/quran/domain/usecases/get_surah.dart';
import 'package:nasaem_aliman/features/quran/domain/usecases/remove_bookmark.dart';

import 'quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  final GetAllSurahs getAllSurahs;
  final GetSurah getSurah;
  // final GetAllJuz getAllJuz;
  final GetJuz getJuz;
  final GetBookmarks getBookmarks;
  final AddBookmark addBookmark;
  final RemoveBookmark removeBookmark;
  final GetLastRead getLastRead;

  List<Bookmark> _currentBookmarks = [];

  QuranCubit(
    this.getAllSurahs,
    this.getSurah,
    // this.getAllJuz,
    this.getJuz,
    this.getBookmarks,
    this.addBookmark,
    this.removeBookmark,
    this.getLastRead,
  ) : super(QuranInitial()) {
    // print("✅ QuranCubit initialized");
  }

  Future<void> fetchSurahs() async {
    // print("📖 [Cubit] fetchSurahs() called");
    emit(QuranLoading());
    try {
      final surahs = await getAllSurahs();
      // print("📖 [Cubit] Surahs fetched: ${surahs.length}");
      emit(SurahsLoaded(surahs));
    } catch (e) {
      // print("❌ [Cubit] Error fetching surahs: $e");
      emit(QuranError(e.toString()));
    }
  }

  Future<void> fetchSurah(int id) async {
    // print("📖 [Cubit] fetchSurah($id) called");
    emit(QuranLoading());
    try {
      final surah = await getSurah(id);
      // print("📖 [Cubit] Surah loaded: ${surah.name}");
      emit(SurahLoaded(surah));
    } catch (e) {
      // print("❌ [Cubit] Error fetching surah: $e");
      emit(QuranError(e.toString()));
    }
  }

  Surah? findSurahById(int surahId) {
    if (state is SurahsLoaded) {
      final surahs = (state as SurahsLoaded).surahs;
      final index = surahs.indexWhere((s) => s.id == surahId);
      return index != -1 ? surahs[index] : null;
    }
    return null;
  }

  Future<void> fetchJuz() async {
    // print("📖 [Cubit] fetchJuz() called");
    emit(QuranLoading());
    try {
      final result = await getJuz();
      // print("📖 [Cubit] Juz fetched: ${result.length}");
      emit(JuzLoaded(result));
    } catch (e) {
      // print("❌ [Cubit] Error fetching Juz: $e");
      emit(QuranError(e.toString()));
    }
  }

  Future<void> fetchBookmarks() async {
    // print("🔖 [Cubit] fetchBookmarks() called");
    try {
      _currentBookmarks = await getBookmarks();
      print("🔖 [Cubit] Bookmarks loaded: ${_currentBookmarks.length}");
      emit(BookmarksLoaded(_currentBookmarks));
    } catch (e) {
      print("❌ [Cubit] Error fetching bookmarks: $e");
      emit(QuranError(e.toString()));
    }
  }

  Future<void> addNewBookmark(Bookmark bookmark) async {
    print(
      "🔖 [Cubit] addNewBookmark: ${bookmark.name} "
      "(Surah ${bookmark.surahId}, Ayah ${bookmark.ayahId})",
    );
    try {
      await addBookmark(_currentBookmarks, bookmark);
      await fetchBookmarks(); // refresh list
    } catch (e, st) {
      print("❌ [Cubit] Error adding bookmark: $e");
      print(st);
      emit(QuranError(e.toString()));
    }
  }

  Future<void> removeExistingBookmark(String bookmarkId) async {
    print("🔖 [Cubit] removeExistingBookmark: $bookmarkId");
    try {
      await removeBookmark(_currentBookmarks, bookmarkId);
      await fetchBookmarks();
    } catch (e, st) {
      print("❌ [Cubit] Error removing bookmark: $e");
      print(st);
      emit(QuranError(e.toString()));
    }
  }

  Future<void> fetchLastRead() async {
    print("📌 [Cubit] fetchLastRead() called");
    try {
      final lastReadBookmark = await getLastRead();
      if (lastReadBookmark != null) {
        print(
          "📌 [Cubit] Last read: Surah ${lastReadBookmark.surahId}, "
          "Ayah ${lastReadBookmark.ayahId}",
        );
      } else {
        print("📌 [Cubit] No last read found");
      }
      emit(LastReadLoaded(lastReadBookmark));
    } catch (e, st) {
      print("❌ [Cubit] Error fetching last read: $e");
      print(st);
      emit(QuranError(e.toString()));
    }
  }
}
