import '../../domain/entities/juz.dart';
import '../../domain/entities/surah.dart';
import '../../domain/entities/ayah.dart';
import '../../domain/repositories/quran_repository.dart';
import '../datasources/quran_local_datasource.dart';
import '../models/surah_model.dart';

class QuranRepositoryImpl implements QuranRepository {
  final QuranLocalDataSource localDataSource;

  QuranRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Juz>> getJuzList() async {
    return await localDataSource.getAllJuz();
  }

  @override
  Future<List<Surah>> getSurahList() async {
    return await localDataSource.getAllSurahs();
  }

  @override
  Future<SurahModel> getSurah(int id) async {
    return await localDataSource.getSurah(id);
  }

  @override
  Future<List<Ayah>> getSurahAyahs(int surahId) async {
    return await localDataSource.getSurahAyahs(surahId);
  }

  @override
  Future<List<Ayah>> getJuzAyahs(int juzId) async {
    return await localDataSource.getJuzAyahs(juzId);
  }
}
