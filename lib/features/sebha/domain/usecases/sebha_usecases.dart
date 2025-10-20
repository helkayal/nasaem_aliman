import '../entities/sebha_zikr_entity.dart';
import '../repositories/sebha_repository.dart';

class GetAllSavedAzkar {
  final SebhaRepository repository;

  GetAllSavedAzkar(this.repository);

  Future<List<SebhaZikrEntity>> call() async {
    return await repository.getAllSavedAzkar();
  }
}

class SaveZikr {
  final SebhaRepository repository;

  SaveZikr(this.repository);

  Future<void> call(SebhaZikrEntity zikr) async {
    await repository.saveZikr(zikr);
  }
}

class UpdateZikr {
  final SebhaRepository repository;

  UpdateZikr(this.repository);

  Future<void> call(SebhaZikrEntity zikr) async {
    await repository.updateZikr(zikr);
  }
}

class DeleteZikr {
  final SebhaRepository repository;

  DeleteZikr(this.repository);

  Future<void> call(String id) async {
    await repository.deleteZikr(id);
  }
}

class GetCurrentZikr {
  final SebhaRepository repository;

  GetCurrentZikr(this.repository);

  Future<SebhaZikrEntity?> call() async {
    return await repository.getCurrentZikr();
  }
}

class SetCurrentZikr {
  final SebhaRepository repository;

  SetCurrentZikr(this.repository);

  Future<void> call(String? zikrId) async {
    await repository.setCurrentZikr(zikrId);
  }
}

class HasDefaultAzkarBeenAdded {
  final SebhaRepository repository;

  HasDefaultAzkarBeenAdded(this.repository);

  Future<bool> call() async {
    return await repository.hasDefaultAzkarBeenAdded();
  }
}

class MarkDefaultAzkarAsAdded {
  final SebhaRepository repository;

  MarkDefaultAzkarAsAdded(this.repository);

  Future<void> call() async {
    await repository.markDefaultAzkarAsAdded();
  }
}
