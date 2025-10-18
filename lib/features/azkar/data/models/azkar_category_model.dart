// data/models/azkar_category_model.dart
// Decoupled pure data model (no inheritance from entity)

import 'azkar_models.dart';

class AzkarCategoryModel {
  final int id;
  final String category;
  final String icon;
  final bool repeatable;
  final List<AzkarModel>
  azkar; // may be empty when first created from categories list

  const AzkarCategoryModel({
    required this.id,
    required this.category,
    required this.icon,
    required this.repeatable,
    required this.azkar,
  });

  // Factory for the categories master list (no embedded azkar list there)
  factory AzkarCategoryModel.fromJson(Map<String, dynamic> json) {
    return AzkarCategoryModel(
      id: json['id'] as int,
      category: json['category'] as String,
      icon: json['icon'] as String,
      repeatable: json['repeatable'] as bool,
      azkar: (json['azkar'] is List)
          ? (json['azkar'] as List)
                .map((e) => AzkarModel.fromJson(e as Map<String, dynamic>))
                .toList()
          : const [],
    );
  }

  AzkarCategoryModel copyWith({List<AzkarModel>? azkar}) => AzkarCategoryModel(
    id: id,
    category: category,
    icon: icon,
    repeatable: repeatable,
    azkar: azkar ?? this.azkar,
  );
}
