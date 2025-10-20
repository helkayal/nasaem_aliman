import '../../domain/entities/sebha_zikr_entity.dart';
import '../../domain/repositories/sebha_repository.dart';
import '../datasources/sebha_local_datasource.dart';
import '../mappers/sebha_mappers.dart';

class SebhaRepositoryImpl implements SebhaRepository {
  final SebhaLocalDataSource localDataSource;

  SebhaRepositoryImpl(this.localDataSource);

  @override
  Future<List<SebhaZikrEntity>> getAllSavedAzkar() async {
    final models = await localDataSource.getAllSavedAzkar();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> saveZikr(SebhaZikrEntity zikr) async {
    await localDataSource.saveZikr(zikr.toModel());
  }

  @override
  Future<void> updateZikr(SebhaZikrEntity zikr) async {
    await localDataSource.updateZikr(zikr.toModel());
  }

  @override
  Future<void> deleteZikr(String id) async {
    await localDataSource.deleteZikr(id);
  }

  @override
  Future<SebhaZikrEntity?> getCurrentZikr() async {
    final model = await localDataSource.getCurrentZikr();
    return model?.toEntity();
  }

  @override
  Future<void> setCurrentZikr(String? zikrId) async {
    await localDataSource.setCurrentZikr(zikrId);
  }

  @override
  Future<bool> hasDefaultAzkarBeenAdded() async {
    return await localDataSource.hasDefaultAzkarBeenAdded();
  }

  @override
  Future<void> markDefaultAzkarAsAdded() async {
    await localDataSource.markDefaultAzkarAsAdded();
  }
}
