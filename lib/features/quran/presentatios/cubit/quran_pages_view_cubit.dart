import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_quran_pages.dart';
import '../../domain/usecases/get_page_for_surah.dart';
import '../../domain/usecases/get_page_for_juz_surah.dart';
import '../../domain/entities/quran_page.dart';
import 'quran_pages_view_state.dart';

class QuranPagesViewCubit extends Cubit<QuranPagesViewState> {
  final GetQuranPages getQuranPages;
  final GetPageForSurah getPageForSurah;
  final GetPageForJuzSurah getPageForJuzSurah;

  List<QuranPageEntity> _allPages = [];
  final Map<int, QuranPageEntity> _loadedPages = {};
  int _currentPage = 1;

  static const int _cacheSize = 5; // Load current + 2 before + 2 after

  QuranPagesViewCubit(
    this.getQuranPages,
    this.getPageForSurah,
    this.getPageForJuzSurah,
  ) : super(QuranPagesViewInitial());

  // Load all pages initially (lightweight - just structure)
  Future<void> loadAllPages() async {
    try {
      emit(QuranPagesViewLoading());
      _allPages = await getQuranPages();

      // Pre-load first few pages
      await _loadPagesRange(1, 3);

      emit(
        QuranPagesViewLoaded(
          pages: _allPages,
          currentPage: _currentPage,
          loadedPages: Map.from(_loadedPages),
          currentSurahName: _getCurrentSurahName(),
          currentJuzName: _getCurrentJuzName(),
        ),
      );
    } catch (e) {
      emit(QuranPagesViewError(e.toString()));
    }
  }

  // Navigate to specific page
  Future<void> goToPage(int pageNumber) async {
    if (pageNumber < 1 || pageNumber > 604) return;

    try {
      emit(QuranPagesViewNavigating(pageNumber));

      _currentPage = pageNumber;
      await _loadPagesRange(pageNumber - 2, pageNumber + 2);

      emit(
        QuranPagesViewLoaded(
          pages: _allPages,
          currentPage: _currentPage,
          loadedPages: Map.from(_loadedPages),
          currentSurahName: _getCurrentSurahName(),
          currentJuzName: _getCurrentJuzName(),
        ),
      );
    } catch (e) {
      emit(QuranPagesViewError(e.toString()));
    }
  }

  // Navigate to surah's starting page
  Future<void> goToSurah(int surahId) async {
    try {
      emit(QuranPagesViewNavigating(_currentPage));

      final pageNumber = await getPageForSurah(surahId);
      await goToPage(pageNumber);
    } catch (e) {
      emit(QuranPagesViewError(e.toString()));
    }
  }

  // Navigate to juz surah page
  Future<void> goToJuzSurah(int juzId, int surahId, int startAyah) async {
    try {
      emit(QuranPagesViewNavigating(_currentPage));

      final pageNumber = await getPageForJuzSurah(juzId, surahId, startAyah);
      await goToPage(pageNumber);
    } catch (e) {
      emit(QuranPagesViewError(e.toString()));
    }
  }

  // Update current page (called by PageView onPageChanged)
  void updateCurrentPage(int pageNumber) {
    if (pageNumber == _currentPage) return;

    _currentPage = pageNumber;

    // Emit state immediately for instant AppBar update
    if (state is QuranPagesViewLoaded) {
      emit(
        (state as QuranPagesViewLoaded).copyWith(
          currentPage: _currentPage,
          currentSurahName: _getCurrentSurahName(),
          currentJuzName: _getCurrentJuzName(),
        ),
      );
    }

    // Load adjacent pages lazily
    _loadPagesRange(pageNumber - 2, pageNumber + 2).then((_) {
      if (state is QuranPagesViewLoaded) {
        emit(
          (state as QuranPagesViewLoaded).copyWith(
            currentPage: _currentPage,
            loadedPages: Map.from(_loadedPages),
            currentSurahName: _getCurrentSurahName(),
            currentJuzName: _getCurrentJuzName(),
          ),
        );
      }
    });
  }

  // Get page entity for display
  QuranPageEntity? getPage(int pageNumber) {
    if (pageNumber < 1 || pageNumber > _allPages.length) return null;
    return _allPages[pageNumber - 1]; // Convert 1-based to 0-based
  }

  // Private helper to load a range of pages with caching
  Future<void> _loadPagesRange(int start, int end) async {
    final clampedStart = start.clamp(1, 604);
    final clampedEnd = end.clamp(1, 604);

    for (int i = clampedStart; i <= clampedEnd; i++) {
      if (!_loadedPages.containsKey(i) && i <= _allPages.length) {
        _loadedPages[i] = _allPages[i - 1]; // Convert 1-based to 0-based
      }
    }

    // Clean up cache if it gets too large
    if (_loadedPages.length > _cacheSize * 3) {
      final currentPageKeys = List.generate(
        _cacheSize,
        (index) => _currentPage - 2 + index,
      ).where((key) => key >= 1 && key <= 604).toSet();

      _loadedPages.removeWhere((key, _) => !currentPageKeys.contains(key));
    }
  }

  // Get current page number
  int get currentPageNumber => _currentPage;

  // Get total pages count
  int get totalPages => 604;

  // Check if page is loaded
  bool isPageLoaded(int pageNumber) => _loadedPages.containsKey(pageNumber);

  // Get current surah name for AppBar
  String _getCurrentSurahName() {
    final currentPageEntity = getPage(_currentPage);
    return currentPageEntity?.displaySurahName ?? "المصحف الشريف";
  }

  // Get current juz name for AppBar
  String _getCurrentJuzName() {
    final currentPageEntity = getPage(_currentPage);
    return currentPageEntity?.displayJuzName ?? "الجزء الأول";
  }
}
