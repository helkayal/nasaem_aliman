// domain/usecases/get_azkar_categories.dart

import '../entities/azkar_category_entiti.dart';
import '../repositories/azkar_category_repository.dart';

class GetAzkarCategories {
  final AzkarCategoriesRepository repository;

  GetAzkarCategories(this.repository);

  Future<List<AzkarCategoryEntity>> call() async {
    return await repository.getAzkar();
  }
}
