import '../../domain/entities/juz.dart';
import '../../domain/entities/surah.dart';
import '../../domain/entities/ayah.dart';
import '../../domain/repositories/quran_repository.dart';
import '../datasources/quran_local_datasource.dart';
import '../models/ayah_model.dart';
import '../models/surah_model.dart';

class QuranRepositoryImpl implements QuranRepository {
  final QuranLocalDataSource localDataSource;

  QuranRepositoryImpl({required this.localDataSource});

  @override
  Future<List<JuzEntity>> getJuzList() async {
    return await localDataSource.getAllJuz();
  }

  @override
  Future<List<SurahEntity>> getSurahList() async {
    return await localDataSource.getAllSurahs();
  }

  @override
  Future<SurahModel> getSurah(int id) async {
    return await localDataSource.getSurah(id);
  }

  @override
  Future<List<AyahEntity>> getSurahAyahs(int surahId) async {
    final models = await localDataSource.getSurahAyahs(surahId);
    return models
        .map(
          (m) => AyahEntity(
            id: m.id,
            surahId: m.surahId,
            number: m.number,
            text: m.text,
          ),
        )
        .toList();
  }

  @override
  Future<List<AyahEntity>> getJuzAyahs(int juzId) async {
    final models = await localDataSource.getJuzAyahs(juzId);
    return models
        .map(
          (m) => AyahEntity(
            id: m.id,
            surahId: m.surahId,
            number: m.number,
            text: m.text,
          ),
        )
        .toList();
  }

  @override
  Future<Map<int, List<AyahEntity>>> groupAyahsByPage(
    List<AyahEntity> ayahs,
    int surahNumber,
  ) async {
    // Convert entities to models before passing
    final models = ayahs
        .map(
          (a) => AyahModel(
            id: a.id,
            surahId: a.surahId,
            number: a.number,
            text: a.text,
          ),
        )
        .toList();

    final groupedModels = await localDataSource.groupAyahsByPage(
      models,
      surahNumber,
    );

    // Convert back models → entities
    return groupedModels.map((page, ayahModels) {
      return MapEntry(
        page,
        ayahModels
            .map(
              (m) => AyahEntity(
                id: m.id,
                surahId: m.surahId,
                number: m.number,
                text: m.text,
              ),
            )
            .toList(),
      );
    });
  }
}
