// domain/entities/azkar_category_entity.dart
import 'azkar_entity.dart';

class AzkarCategoryEntity {
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
}
