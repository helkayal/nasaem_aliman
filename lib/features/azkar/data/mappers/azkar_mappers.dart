import '../../domain/entities/azkar_entity.dart';
import '../../domain/entities/azkar_category_entiti.dart';
import '../models/azkar_models.dart';
import '../models/azkar_category_model.dart';

extension AzkarModelMapper on AzkarModel {
  AzkarEntity toEntity() => AzkarEntity(
    id: id,
    text: text,
    count: count,
    audio: audio,
    filename: filename,
  );
}

extension AzkarEntityMapper on AzkarEntity {
  AzkarModel toModel() => AzkarModel(
    id: id,
    text: text,
    count: count,
    audio: audio,
    filename: filename,
  );
}

extension AzkarCategoryModelMapper on AzkarCategoryModel {
  AzkarCategoryEntity toEntity() => AzkarCategoryEntity(
    id: id,
    category: category,
    repeatable: repeatable,
    azkar: azkar.map((a) => a.toEntity()).toList(),
  );
}
