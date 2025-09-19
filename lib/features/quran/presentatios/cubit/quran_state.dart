import 'package:equatable/equatable.dart';
import 'package:nasaem_aliman/features/quran/domain/entities/bookmark.dart';
import 'package:nasaem_aliman/features/quran/domain/entities/juz.dart';
import 'package:nasaem_aliman/features/quran/domain/entities/surah.dart';

abstract class QuranState extends Equatable {
  @override
  List<Object?> get props => [];
}

class QuranInitial extends QuranState {}

class QuranLoading extends QuranState {}

class QuranError extends QuranState {
  final String message;
  QuranError(this.message);

  @override
  List<Object?> get props => [message];
}

class SurahsLoaded extends QuranState {
  final List<Surah> surahs;
  SurahsLoaded(this.surahs);

  @override
  List<Object?> get props => [surahs];
}

class SurahLoaded extends QuranState {
  final Surah surah;
  SurahLoaded(this.surah);

  @override
  List<Object?> get props => [surah];
}

class JuzLoaded extends QuranState {
  final List<Juz> juzList;
  JuzLoaded(this.juzList);

  @override
  List<Object?> get props => [juzList];
}

class BookmarksLoaded extends QuranState {
  final List<Bookmark> bookmarks;
  BookmarksLoaded(this.bookmarks);

  @override
  List<Object?> get props => [bookmarks];
}

class LastReadLoaded extends QuranState {
  final Bookmark? lastRead;
  LastReadLoaded(this.lastRead);

  @override
  List<Object?> get props => [lastRead];
}
