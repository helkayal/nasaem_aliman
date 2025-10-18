import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/azkar_category_model.dart';
import '../models/azkar_models.dart';

abstract class AzkarCategoriesLocalDataSource {
  Future<List<AzkarCategoryModel>> getAzkarCategories();
}

class AzkarCategoriesLocalDataSourceImpl
    implements AzkarCategoriesLocalDataSource {
  static const _azkarPath = 'assets/data/azkar.json';

  @override
  Future<List<AzkarCategoryModel>> getAzkarCategories() async {
    final raw = await rootBundle.loadString(_azkarPath);
    final list = json.decode(raw) as List;

    final result = <AzkarCategoryModel>[];

    for (final item in list) {
      final categoryData = item as Map<String, dynamic>;

      // Parse azkar items from the 'array' field
      final azkarArray = categoryData['array'] as List? ?? [];
      final azkarItems = azkarArray
          .map(
            (azkarJson) =>
                AzkarModel.fromJson(azkarJson as Map<String, dynamic>),
          )
          .toList();

      // Create category with embedded azkar items
      final category = AzkarCategoryModel(
        id: categoryData['id'] as int,
        category: categoryData['category'] as String,
        icon: categoryData['icon'] as String,
        repeatable: true, // Default value since not in new structure
        azkar: azkarItems,
      );

      result.add(category);
    }

    return result;
  }
}
