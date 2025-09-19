import '../../domain/entities/surah.dart';
import '../../domain/entities/ayah.dart';
import '../../domain/entities/juz.dart';

abstract class QuranState {}

class QuranInitial extends QuranState {}

class QuranLoading extends QuranState {}

class QuranError extends QuranState {
  final String message;
  QuranError(this.message);
}

// Surahs

class SurahListLoading extends QuranState {}

class SurahListLoaded extends QuranState {
  final List<Surah> surahs;
  SurahListLoaded(this.surahs);
}

// class SurahLoading extends QuranState {}

// class SurahLoaded extends QuranState {
//   final Surah surah;
//   SurahLoaded(this.surah);
// }

// Juz

class JuzLoading extends QuranState {}

class JuzListLoaded extends QuranState {
  final List<Juz> juzList;
  JuzListLoaded(this.juzList);
}

class JuzAyahsLoading extends QuranState {}

class JuzAyahsLoaded extends QuranState {
  final int juzId;
  final List<Ayah> ayahs;
  JuzAyahsLoaded(this.juzId, this.ayahs);
}

// Bookmarks
class BookmarksLoaded extends QuranState {
  final List<Ayah> bookmarks;
  BookmarksLoaded(this.bookmarks);
}

// Last Read
class LastReadLoaded extends QuranState {
  final Ayah? lastRead;
  LastReadLoaded(this.lastRead);
}
