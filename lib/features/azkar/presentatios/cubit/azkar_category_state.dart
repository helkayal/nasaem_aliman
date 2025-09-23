import '../../domain/entities/azkar_category_entiti.dart';

abstract class AzkarCategoriesState {}

class AzkarCategoriesInitial extends AzkarCategoriesState {}

class AzkarCategoriesLoading extends AzkarCategoriesState {}

class AzkarCategoriesLoaded extends AzkarCategoriesState {
  final List<AzkarCategoryEntity> categories;
  AzkarCategoriesLoaded(this.categories);
}

class AzkarCategoriesError extends AzkarCategoriesState {
  final String message;
  AzkarCategoriesError(this.message);
}
