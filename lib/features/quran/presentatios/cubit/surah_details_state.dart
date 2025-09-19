import '../../domain/entities/surah.dart';

abstract class SurahDetailsState {}

class SurahDetailsInitial extends SurahDetailsState {}

class SurahDetailsLoading extends SurahDetailsState {}

class SurahDetailsLoaded extends SurahDetailsState {
  final Surah surah;
  SurahDetailsLoaded(this.surah);
}

class SurahDetailsError extends SurahDetailsState {
  final String message;
  SurahDetailsError(this.message);
}
