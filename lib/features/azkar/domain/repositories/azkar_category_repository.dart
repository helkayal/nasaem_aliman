// domain/repositories/azkar_repository.dart
import '../entities/azkar_category_entity.dart';

abstract class AzkarCategoriesRepository {
  Future<List<AzkarCategoryEntity>> getAzkar();
}
