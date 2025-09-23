// data/models/azkar_category_model.dart

import '../../domain/entities/azkar_category_entiti.dart';
import 'azkar_models.dart';

class AzkarCategoryModel extends AzkarCategoryEntity {
  const AzkarCategoryModel({
    required super.id,
    required super.category,
    required super.repeatable,
    required super.azkar,
  });

  factory AzkarCategoryModel.fromJson(Map<String, dynamic> json) {
    return AzkarCategoryModel(
      id: json['id'],
      category: json['category'],
      repeatable: json['repeatable'],
      azkar: (json['azkar'] as List)
          .map((a) => AzkarModel.fromJson(a))
          .toList(),
    );
  }
}
