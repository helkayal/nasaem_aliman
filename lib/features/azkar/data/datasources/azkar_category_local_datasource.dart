// data/datasources/azkar_local_datasource.dart
// New structure: categories listed in assets/data/azkar_categories.json
// individual azkar items for each category stored in assets/data/azkar/XX.json (zero-padded id)

import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/azkar_category_model.dart';
import '../models/azkar_models.dart';

abstract class AzkarCategoriesLocalDataSource {
  Future<List<AzkarCategoryModel>> getAzkarCategories();
}

class AzkarCategoriesLocalDataSourceImpl
    implements AzkarCategoriesLocalDataSource {
  static const _categoriesPath = 'assets/data/azkar_categories.json';
  static const _azkarFolder = 'assets/data/azkar';

  @override
  Future<List<AzkarCategoryModel>> getAzkarCategories() async {
    final raw = await rootBundle.loadString(_categoriesPath);
    final list = json.decode(raw) as List;
    final categories = list
        .map((e) => AzkarCategoryModel.fromJson(e as Map<String, dynamic>))
        .toList();

    // Attempt to eagerly load azkar items for each category. If missing file, keep empty list.
    final result = <AzkarCategoryModel>[];
    for (final cat in categories) {
      final fileName = cat.id.toString().padLeft(2, '0');
      final path = '$_azkarFolder/$fileName.json';
      List<AzkarModel> azkarItems = const [];
      try {
        final azkarRaw = await rootBundle.loadString(path);
        final azkarList = json.decode(azkarRaw) as List;
        azkarItems = azkarList
            .map((a) => AzkarModel.fromJson(a as Map<String, dynamic>))
            .toList();
      } catch (_) {
        // Silently ignore missing file or parse error; category stays with empty azkar list.
      }
      result.add(cat.copyWith(azkar: azkarItems));
    }

    return result;
  }
}
