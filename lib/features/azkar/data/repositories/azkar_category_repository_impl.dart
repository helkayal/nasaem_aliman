// data/repositories/azkar_repository_impl.dart

import '../../domain/entities/azkar_category_entiti.dart';
import '../../domain/repositories/azkar_category_repository.dart';
import '../datasources/azkar_category_local_datasource.dart';

class AzkarCategoriesRepositoryImpl implements AzkarCategoriesRepository {
  final AzkarCategoriesLocalDataSource localDataSource;

  AzkarCategoriesRepositoryImpl(this.localDataSource);

  @override
  Future<List<AzkarCategoryEntity>> getAzkar() async {
    return await localDataSource.getAzkarCategories();
  }
}
