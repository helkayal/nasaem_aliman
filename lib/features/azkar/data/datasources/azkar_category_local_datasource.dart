// data/datasources/azkar_local_datasource.dart
import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/azkar_category_model.dart';

abstract class AzkarCategoriesLocalDataSource {
  Future<List<AzkarCategoryModel>> getAzkarCategories();
}

class AzkarCategoriesLocalDataSourceImpl
    implements AzkarCategoriesLocalDataSource {
  @override
  Future<List<AzkarCategoryModel>> getAzkarCategories() async {
    final response = await rootBundle.loadString('assets/data/azkar.json');
    final data = json.decode(response) as List;
    return data.map((c) => AzkarCategoryModel.fromJson(c)).toList();
  }
}
