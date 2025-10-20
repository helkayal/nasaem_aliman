import '../../domain/entities/sebha_zikr_entity.dart';
import '../models/sebha_zikr_model.dart';

extension SebhaZikrModelMapper on SebhaZikrModel {
  SebhaZikrEntity toEntity() => SebhaZikrEntity(
    id: id,
    text: text,
    currentCount: currentCount,
    createdAt: createdAt,
    lastUsedAt: lastUsedAt,
  );
}

extension SebhaZikrEntityMapper on SebhaZikrEntity {
  SebhaZikrModel toModel() => SebhaZikrModel(
    id: id,
    text: text,
    currentCount: currentCount,
    createdAt: createdAt,
    lastUsedAt: lastUsedAt,
  );
}
