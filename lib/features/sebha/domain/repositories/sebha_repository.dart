import '../entities/sebha_zikr_entity.dart';

abstract class SebhaRepository {
  Future<List<SebhaZikrEntity>> getAllSavedAzkar();
  Future<void> saveZikr(SebhaZikrEntity zikr);
  Future<void> updateZikr(SebhaZikrEntity zikr);
  Future<void> deleteZikr(String id);
  Future<SebhaZikrEntity?> getCurrentZikr();
  Future<void> setCurrentZikr(String? zikrId);
  Future<bool> hasDefaultAzkarBeenAdded();
  Future<void> markDefaultAzkarAsAdded();
}
