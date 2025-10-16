import '../../domain/entities/juz.dart';
import '../../domain/entities/surah.dart';
import '../../domain/entities/ayah.dart';
import '../../domain/entities/quran_page.dart';
import '../../domain/repositories/quran_repository.dart';
import '../datasources/quran_local_datasource.dart';
import '../models/surah_model.dart';
import '../mappers/quran_mappers.dart';

class QuranRepositoryImpl implements QuranRepository {
  final QuranLocalDataSource localDataSource;

  QuranRepositoryImpl({required this.localDataSource});

  @override
  Future<List<JuzEntity>> getJuzList() async {
    final models = await localDataSource.getAllJuz();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<SurahEntity>> getSurahList() async {
    final models = await localDataSource.getAllSurahs();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<SurahEntity> getSurah(int id) async {
    final SurahModel model = await localDataSource.getSurah(id);
    return model.toEntity();
  }

  @override
  Future<List<AyahEntity>> getSurahAyahs(int surahId) async {
    final models = await localDataSource.getSurahAyahs(surahId);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<AyahEntity>> getJuzAyahs(int juzId) async {
    final models = await localDataSource.getJuzAyahs(juzId);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<Map<int, List<AyahEntity>>> groupAyahsByPage(
    List<AyahEntity> ayahs,
    int surahNumber,
  ) async {
    final models = ayahs.map((a) => a.toModel()).toList();
    final groupedModels = await localDataSource.groupAyahsByPage(
      models,
      surahNumber,
    );
    return groupedModels.map(
      (page, list) => MapEntry(page, list.map((m) => m.toEntity()).toList()),
    );
  }

  // New page-based methods
  @override
  Future<List<QuranPageEntity>> getAllQuranPages() async {
    final models = await localDataSource.getAllQuranPages();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<int> getPageForSurah(int surahId) async {
    return await localDataSource.getPageForSurah(surahId);
  }

  @override
  Future<int> getPageForJuzSurah(int juzId, int surahId, int startAyah) async {
    return await localDataSource.getPageForJuzSurah(juzId, surahId, startAyah);
  }
}
