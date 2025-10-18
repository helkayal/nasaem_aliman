import 'package:equatable/equatable.dart';
import '../../domain/entities/azkar_category_entity.dart';

abstract class AzkarCategoriesState extends Equatable {
  const AzkarCategoriesState();
  @override
  List<Object?> get props => [];
}

class AzkarCategoriesInitial extends AzkarCategoriesState {
  const AzkarCategoriesInitial();
}

class AzkarCategoriesLoading extends AzkarCategoriesState {
  const AzkarCategoriesLoading();
}

class AzkarCategoriesLoaded extends AzkarCategoriesState {
  final List<AzkarCategoryEntity> categories;
  const AzkarCategoriesLoaded(this.categories);

  @override
  List<Object?> get props => [categories];
}

class AzkarCategoriesError extends AzkarCategoriesState {
  final String message;
  const AzkarCategoriesError(this.message);

  @override
  List<Object?> get props => [message];
}
