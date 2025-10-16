import '../../domain/entities/quran_page.dart';

abstract class QuranPagesViewState {}

class QuranPagesViewInitial extends QuranPagesViewState {}

class QuranPagesViewLoading extends QuranPagesViewState {}

class QuranPagesViewError extends QuranPagesViewState {
  final String message;
  QuranPagesViewError(this.message);
}

class QuranPagesViewLoaded extends QuranPagesViewState {
  final List<QuranPageEntity> pages;
  final int currentPage;
  final Map<int, QuranPageEntity> loadedPages; // For caching
  final String currentSurahName;
  final String currentJuzName;

  QuranPagesViewLoaded({
    required this.pages,
    required this.currentPage,
    required this.loadedPages,
    required this.currentSurahName,
    required this.currentJuzName,
  });

  QuranPagesViewLoaded copyWith({
    List<QuranPageEntity>? pages,
    int? currentPage,
    Map<int, QuranPageEntity>? loadedPages,
    String? currentSurahName,
    String? currentJuzName,
  }) {
    return QuranPagesViewLoaded(
      pages: pages ?? this.pages,
      currentPage: currentPage ?? this.currentPage,
      loadedPages: loadedPages ?? this.loadedPages,
      currentSurahName: currentSurahName ?? this.currentSurahName,
      currentJuzName: currentJuzName ?? this.currentJuzName,
    );
  }
}

class QuranPagesViewNavigating extends QuranPagesViewState {
  final int targetPage;
  QuranPagesViewNavigating(this.targetPage);
}
