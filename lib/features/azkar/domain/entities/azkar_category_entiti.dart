// domain/entities/azkar_category_entity.dart
import 'package:equatable/equatable.dart';
import 'azkar_entity.dart';

class AzkarCategoryEntity extends Equatable {
  final int id;
  final String category;
  final bool repeatable;
  final List<AzkarEntity> azkar;

  const AzkarCategoryEntity({
    required this.id,
    required this.category,
    required this.repeatable,
    required this.azkar,
  });

  @override
  List<Object?> get props => [id, category, repeatable, azkar];
}
